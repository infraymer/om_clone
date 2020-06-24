import 'package:json_annotation/json_annotation.dart';

part 'setting_filter.g.dart';

@JsonSerializable()
class SettingFilter {
  final int ageMin;
  final int ageMax;
  final String gender;
  final double maxDistance;

  SettingFilter(this.ageMin, this.ageMax, this.gender, this.maxDistance);

  factory SettingFilter.fromJson(Map<String, dynamic> json) => _$SettingFilterFromJson(json);
}