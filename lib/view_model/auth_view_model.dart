import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';

class AuthViewModel extends ChangeNotifier {
  final _userRemoteDataSource = UserRemoteDataSource();

  bool isLoggedIn = false;
  User profile;

  AuthViewModel() {
    checkAuth();
  }

  Future<void> checkAuth() async {
    isLoggedIn = await isAuth;
    if (isLoggedIn)
      profile = await _userRemoteDataSource.me();
    notifyListeners();
  }

  Future<bool> get isAuth async {
    final user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  Future<void> logIn() async {
    isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    isLoggedIn = false;
    notifyListeners();
  }
}