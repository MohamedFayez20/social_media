import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/shared/cubit/states.dart';

import '../../modules/user_data.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  Map? data;
  void signInFaceBook(context) async {
    final result = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    if (result.status == LoginStatus.success) {
      emit(SignInFaceLoadingState());
      final requestData = await FacebookAuth.instance
          .getUserData(fields: "email, name, picture.width(300)");
      data = requestData;
      print(data);
      if (data != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserData(),
          ),
        );
      }
      emit(SignInState());
    }
  }

  bool isFaceBook = false;

  void signOutFaceBook(context) async {
    emit(SignOutFaceLoadingState());
    FacebookAuth.instance.logOut();
    FacebookAuth.instance.accessToken.then((value) {
      value = null;
      data = null;
      emit(SignOutState());
    });
    isFaceBook == false;
  }

  GoogleSignInAccount? userData;
  GoogleSignIn? signIn;
  void signInGoogle(context) {
    emit(SignInGoogleLoadingState());
    signIn = GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    );
    signIn!.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      userData = account;
    });

    signIn!.signIn().then((value) {
      if (value != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserData()),
        );
      }
    });

    emit(SignInGoogleState());
  }

  void signOutGoogle() {
    emit(SignOutGoogleLoadingState());
    signIn!.signOut().then((value) {
      userData = null;
    });
    emit(SignOutGoogleState());
  }
}
