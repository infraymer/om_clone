import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tinder/screens/code_screen.dart';
import 'package:tinder/screens/login_screen.dart';
import 'package:tinder/screens/match_screen.dart';
import 'package:tinder/screens/phone_screen.dart';
import 'package:tinder/screens/registration_screen.dart';
import 'package:tinder/screens/welcome_screen.dart';
import 'package:tinder/utils/auth_firebase.dart';
import 'package:tinder/view_model/registration_view_model.dart';

class LoginRoute extends CupertinoPageRoute {
  LoginRoute() : super(builder: (ctx) => LoginScreen());
}

class PhoneRoute extends CupertinoPageRoute {
  PhoneRoute() : super(builder: (ctx) => PhoneScreen());
}

class CodeRoute extends CupertinoPageRoute {
  CodeRoute(AuthPhoneFirebase authPhone)
      : super(builder: (ctx) => CodeScreen(authPhone: authPhone));
}

class WelcomeRoute extends CupertinoPageRoute {
  WelcomeRoute() : super(builder: (ctx) => WelcomeScreen());
}

class RegistrationRoute extends CupertinoPageRoute {
  RegistrationRoute()
      : super(
          builder: (ctx) => ChangeNotifierProvider<RegistrationViewModel>(
            create: (_) => RegistrationViewModel(),
            child: RegistrationScreen(),
          ),
        );
}

class MatchRoute extends CupertinoPageRoute {
  MatchRoute() : super(builder: (ctx) => MatchScreen());
}
