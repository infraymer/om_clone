import 'package:flutter/material.dart';
import 'package:tinder/model/gender.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';

class SettingsViewModel extends ChangeNotifier {
  final _userRemoteDataSource = UserRemoteDataSource();

  User user;
  bool isLoading = false;
  String error;

  int minAge = 18;
  int maxAge = 99;
  int distance = 2;
  Gender gender = Gender.all;

  set _user(value) {
    user = value;
    isLoading = false;
    error = null;
  }

  set _isLoading(value) {
    isLoading = value;
    error = null;
  }

  set _error(value) {
    error = value;
    isLoading = false;
  }

  setGender(Gender value) {
    gender = value;
    notifyListeners();
  }

  SettingsViewModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await _userRemoteDataSource.me();
      notifyListeners();
    } catch(e) {
      _error = 'Error loading';
      notifyListeners();
    }
  }

  update() {
    notifyListeners();
  }
}
