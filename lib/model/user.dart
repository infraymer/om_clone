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
  @JsonKey(toJson: dateToUtc)
  final DateTime lastSeen;
  final double lat;
  final double lan;
  @JsonKey(toJson: dateToUtc)
  final DateTime birthDate;
  final int imgsLength;
  final String match;
  final bool showMyGender;
  final SettingFilter settingFilter;
  final String gender;
  final String aboutMe;
  final List<String> feed;

  int get age => DateTime.now().year - (birthDate?.year ?? 0);

  User(
      {this.uid,
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
      this.feed});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String uid,
    List<String> imgs,
    String name,
    String lastName,
    String displayName,
    DateTime lastSeen,
    double lat,
    double lan,
    DateTime birthDate,
    int imgsLength,
    String match,
    bool showMyGender,
    SettingFilter settingFilter,
    String gender,
    String aboutMe,
    List<String> feed,
  }) {
    return new User(
      uid: uid ?? this.uid,
      imgs: imgs ?? this.imgs,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      lastSeen: lastSeen ?? this.lastSeen,
      lat: lat ?? this.lat,
      lan: lan ?? this.lan,
      birthDate: birthDate ?? this.birthDate,
      imgsLength: imgsLength ?? this.imgsLength,
      match: match ?? this.match,
      showMyGender: showMyGender ?? this.showMyGender,
      settingFilter: settingFilter ?? this.settingFilter,
      gender: gender ?? this.gender,
      aboutMe: aboutMe ?? this.aboutMe,
      feed: feed ?? this.feed,
    );
  }

  static String dateToUtc(DateTime date) {
    return date?.toUtc()?.toIso8601String();
  }
}
