import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {

  bool isLoggedIn = false;

  AuthViewModel() {
    checkAuth();
  }

  Future<void> checkAuth() async {
    isLoggedIn = await isAuth;
    notifyListeners();
  }

  Future<bool> get isAuth async {
    final user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    isLoggedIn = false;
    notifyListeners();
  }
}