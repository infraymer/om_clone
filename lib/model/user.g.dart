// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['uid'] as String,
    (json['imgs'] as List)?.map((e) => e as String)?.toList(),
    json['lastName'] as String,
    json['displayName'] as String,
    json['lastSeen'] == null
        ? null
        : DateTime.parse(json['lastSeen'] as String),
    (json['lat'] as num)?.toDouble(),
    (json['lan'] as num)?.toDouble(),
    json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    json['imgsLength'] as int,
    json['match'] as String,
    json['showMyGender'] as bool,
    json['settingFilter'] == null
        ? null
        : SettingFilter.fromJson(json['settingFilter'] as Map<String, dynamic>),
    json['name'] as String,
    json['gender'] as String,
    json['aboutMe'] as String,
    (json['feed'] as List)?.map((e) => e as String)?.toList(),
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
