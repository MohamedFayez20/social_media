import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/shared/style/style.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/1.jpg'),
              opacity: 430,
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in now',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const SizedBox(height: 40),
                  condition(
                      InkWell(
                          onTap: () {
                            AppCubit.get(context).isFaceBook = true;
                            AppCubit.get(context).signInFaceBook(context);
                          },
                          child: media('2')),
                      state is! SignInFaceLoadingState),
                  const SizedBox(height: 40),
                  const Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  condition(
                      InkWell(
                          onTap: () {
                            AppCubit.get(context).isFaceBook = false;
                            AppCubit.get(context).signInGoogle(context);
                          },
                          child: media('3')),
                      state is! SignInGoogleLoadingState)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
