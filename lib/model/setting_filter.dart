import 'package:json_annotation/json_annotation.dart';

part 'setting_filter.g.dart';

@JsonSerializable()
class SettingFilter {
  final int ageMin;
  final int ageMax;
  final String gender;
  final int distanceMax;

  SettingFilter(this.ageMin, this.ageMax, this.gender, this.distanceMax);

  factory SettingFilter.fromJson(Map<String, dynamic> json) => _$SettingFilterFromJson(json);
  Map<String, dynamic> toJson() => _$SettingFilterToJson(this);
}