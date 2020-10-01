import 'package:flutter/cupertino.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/screens/auth_screen.dart';
import 'package:tinder/screens/chat/chat_screen.dart';
import 'package:tinder/screens/code_screen.dart';
import 'package:tinder/screens/login_screen.dart';
import 'package:tinder/screens/match_screen.dart';
import 'package:tinder/screens/phone_screen.dart';
import 'package:tinder/screens/profile_screen.dart';
import 'package:tinder/screens/registration_screen.dart';
import 'package:tinder/screens/selection_screen.dart';
import 'package:tinder/screens/settings_screen.dart';
import 'package:tinder/screens/terms_and_conditions_screen.dart';
import 'package:tinder/screens/welcome_screen.dart';
import 'package:tinder/utils/auth_firebase.dart';

class AuthRoute extends CupertinoPageRoute {
  AuthRoute() : super(builder: (ctx) => AuthScreen());
}

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
  RegistrationRoute() : super(builder: (ctx) => RegistrationScreen());
}

class MatchRoute extends CupertinoPageRoute {
  MatchRoute(User matchUser)
      : super(builder: (ctx) => MatchScreen(matchUser: matchUser));
}

class SelectionRoute extends CupertinoPageRoute {
  SelectionRoute() : super(builder: (ctx) => SelectionScreen());
}

class ChatRoute extends CupertinoPageRoute {
  ChatRoute(User user) : super(builder: (ctx) => ChatScreen(user: user));
}

class SettingsRoute extends CupertinoPageRoute {
  SettingsRoute() : super(builder: (ctx) => SettingsScreen());
}

class TermsAndConditionsRoute extends CupertinoPageRoute {
  TermsAndConditionsRoute()
      : super(builder: (ctx) => TermsAndConditionsScreen());
}

class ProfileRoute extends CupertinoPageRoute {
  ProfileRoute(user) : super(builder: (ctx) => ProfileScreen(user: user));
}

class FadePageRoue extends PageRouteBuilder {
  final Widget widget;

  FadePageRoue(this.widget)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            );
          },
        );
}
