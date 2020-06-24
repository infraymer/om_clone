import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/model/setting_filter.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final List<String> imgs;
  final String name;
  final String lastName;
  final String displayName;
  final DateTime lastSeen;
  final double lat;
  final double lan;
  final DateTime birthDate;
  final int imgsLength;
  final String match;
  final bool showMyGender;
  final SettingFilter settingFilter;
  final String gender;
  final String aboutMe;
  final List<String> feed;

  int get age => DateTime.now().year - birthDate.year;

  User(
      this.uid,
      this.imgs,
      this.lastName,
      this.displayName,
      this.lastSeen,
      this.lat,
      this.lan,
      this.birthDate,
      this.imgsLength,
      this.match,
      this.showMyGender,
      this.settingFilter,
      this.name,
      this.gender,
      this.aboutMe,
      this.feed);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
