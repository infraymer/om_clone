// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingFilter _$SettingFilterFromJson(Map<String, dynamic> json) {
  return SettingFilter(
    json['ageMin'] as int,
    json['ageMax'] as int,
    json['gender'] as String,
    json['distanceMax'] as int,
  );
}

Map<String, dynamic> _$SettingFilterToJson(SettingFilter instance) =>
    <String, dynamic>{
      'ageMin': instance.ageMin,
      'ageMax': instance.ageMax,
      'gender': instance.gender,
      'distanceMax': instance.distanceMax,
    };
