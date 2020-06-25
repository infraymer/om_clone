// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    uid: json['uid'] as String,
    imgs: (json['imgs'] as List)?.map((e) => e as String)?.toList(),
    lastName: json['lastName'] as String,
    displayName: json['displayName'] as String,
    lastSeen: json['lastSeen'] == null
        ? null
        : DateTime.parse(json['lastSeen'] as String),
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

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'imgs': instance.imgs,
      'name': instance.name,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'lat': instance.lat,
      'lan': instance.lan,
      'birthDate': instance.birthDate?.toIso8601String(),
      'imgsLength': instance.imgsLength,
      'match': instance.match,
      'showMyGender': instance.showMyGender,
      'settingFilter': instance.settingFilter,
      'gender': instance.gender,
      'aboutMe': instance.aboutMe,
      'feed': instance.feed,
    };
