import 'package:flutter/material.dart';
import 'package:tinder/model/gender.dart';
import 'package:tinder/model/setting_filter.dart';
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
  String about = '';

  bool saved = false;

  set _user(User value) {
    user = value;
    isLoading = false;
    error = null;

    final sf = value.settingFilter;
    minAge = sf?.ageMin ?? 18;
    maxAge = sf?.ageMax ?? 99;
    distance = sf?.maxDistance ?? 2;
    gender = sf?.gender?.toGender() ?? Gender.all;

    about = value.aboutMe ?? '';
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
    } catch (e) {
      _error = 'Error loading';
      notifyListeners();
    }
  }

  update() {
    notifyListeners();
  }

  Future<void> onDoneClicked() async {
    try {
      _isLoading = true;
      notifyListeners();
      final data = user.copyWith(
        aboutMe: about,
        settingFilter: SettingFilter(
          minAge,
          maxAge,
          gender.key,
          distance,
        ),
      );
      await _userRemoteDataSource.updateUser(data);
      saved = true;
    } catch(e) {
       _error = 'Error update user';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
