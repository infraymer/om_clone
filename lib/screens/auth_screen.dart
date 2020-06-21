import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/screens/login_screen.dart';
import 'package:tinder/screens/selection_screen.dart';
import 'package:tinder/view_model/auth_view_model.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    if (model.isLoggedIn) return SelectionScreen();
    return LoginScreen();
  }
}
