import 'package:tinder/model/setting_filter.dart';
import 'package:tinder/model/user.dart';

class MeMapper {

  static User mapToUser(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      imgs: (json['imgs'] as List)?.map((e) => e as String)?.toList(),
      lastName: json['lastName'] as String,
      displayName: json['displayName'] as String,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch((json['lastSeen']['_seconds'] as int) * 1000),
      lat: (json['lat'] as num)?.toDouble(),
      lan: (json['lan'] as num)?.toDouble(),
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      imgsLength: json['imgsLength'] as int,
      match: json['match'] as String,
      showMyGender: json['showMyGender'] as bool,
      settingFilter: json['settingFilter'] == null
          ? null
          : SettingFilter.fromJson(json['settingFilter'] as Map<String, dynamic>),
      name: json['name'] as String,
      gender: json['gender'] as String,
      aboutMe: json['aboutMe'] as String,
      feed: (json['feed'] as List)?.map((e) => e as String)?.toList(),
    );
  }
}