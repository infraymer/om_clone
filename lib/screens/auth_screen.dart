import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tinder/screens/login_screen.dart';
import 'package:tinder/screens/registration_screen.dart';
import 'package:tinder/screens/selection_screen.dart';
import 'package:tinder/screens/splash_screen.dart';
import 'package:tinder/view_model/auth_controller.dart';
import 'package:tinder/view_model/selection_controller.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return StreamBuilder<AuthState>(
//      stream: AuthController.to.authState.stream,
//      builder: (context, snap) {
//        switch (snap.data) {
//          case AuthState.login:
//            return LoginScreen();
//            break;
//          case AuthState.registration:
//            return RegistrationScreen();
//            break;
//          case AuthState.home:
//            return SelectionScreen();
//            break;
//          default:
//            return SplashScreen();
//        }
//      },
//    );

    return Obx(() {
        switch (AuthController.to.authState.value) {
          case AuthState.login:
            return LoginScreen();
            break;
          case AuthState.registration:
            return RegistrationScreen();
            break;
          case AuthState.home:
            return SelectionScreen();
            break;
          default:
            return SplashScreen();
        }
      },
    );
  }
}
