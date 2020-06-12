import 'package:flutter/cupertino.dart';
import 'package:tinder/screens/code_screen.dart';
import 'package:tinder/screens/login_screen.dart';
import 'package:tinder/screens/match_screen.dart';
import 'package:tinder/screens/phone_screen.dart';
import 'package:tinder/screens/registration_screen.dart';
import 'package:tinder/screens/welcome_screen.dart';

class LoginRoute extends CupertinoPageRoute {
  LoginRoute() : super(builder: (ctx) => LoginScreen());
}

class PhoneRoute extends CupertinoPageRoute {
  PhoneRoute() : super(builder: (ctx) => PhoneScreen());
}

class CodeRoute extends CupertinoPageRoute {
  CodeRoute() : super(builder: (ctx) => CodeScreen());
}

class WelcomeRoute extends CupertinoPageRoute {
  WelcomeRoute() : super(builder: (ctx) => WelcomeScreen());
}

class RegistrationRoute extends CupertinoPageRoute {
  RegistrationRoute() : super(builder: (ctx) => RegistrationScreen());
}

class MatchRoute extends CupertinoPageRoute {
  MatchRoute() : super(builder: (ctx) => MatchScreen());
}
