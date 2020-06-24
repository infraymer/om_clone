// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FbTime _$FbTimeFromJson(Map<String, dynamic> json) {
  return FbTime(
    json['_seconds'] as int,
    json['_nanoseconds'] as int,
  );
}

Map<String, dynamic> _$FbTimeToJson(FbTime instance) => <String, dynamic>{
      '_seconds': instance.seconds,
      '_nanoseconds': instance.nanoseconds,
    };
