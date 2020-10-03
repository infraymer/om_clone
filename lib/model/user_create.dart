import 'package:tinder/model/setting_filter.dart';

class UserCreate {
  final String name;
  final String gender; // women or men
  final List<String> images;
  final bool showMyGender;
  final String aboutMe;
  final DateTime birthday; // 2020-06-01
  final SettingFilter settingFilter;

  UserCreate(
    this.name,
    this.gender,
    this.images,
    this.showMyGender,
    this.aboutMe,
    this.birthday,
    this.settingFilter,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'gender': this.gender,
      'imgs': this.images,
      'showMyGender': this.showMyGender,
      'aboutMe': this.aboutMe,
      'birthDate': birthday.toUtc().toIso8601String(),
      'settingFilter': settingFilter.toJson(),
    };
  }
}
