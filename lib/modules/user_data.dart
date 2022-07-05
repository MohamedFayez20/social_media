import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/shared/cubit/cubit.dart';
import 'package:social_media/shared/style/style.dart';

import '../shared/cubit/states.dart';
import 'login.dart';

class UserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var nameController = TextEditingController(
        text: cubit.isFaceBook
            ? cubit.data!['name']
            : cubit.userData!.displayName);
    var emailController = TextEditingController(
        text: cubit.isFaceBook ? cubit.data!['email'] : cubit.userData!.email);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/4.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cubit.isFaceBook &&
                      cubit.userData == null &&
                      cubit.data == null) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ] else ...[
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(cubit.isFaceBook
                          ? cubit.data!['picture']['data']['url']
                          : cubit.userData!.photoUrl),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(
                      controller: nameController,
                      i: Icons.person,
                      context: context,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(
                      controller: emailController,
                      i: Icons.email_outlined,
                      context: context,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                        if (cubit.isFaceBook) {
                          cubit.signOutFaceBook(context);
                        } else {
                          cubit.signOutGoogle();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Sign out',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
