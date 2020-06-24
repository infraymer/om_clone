import 'package:json_annotation/json_annotation.dart';

part 'fb_time.g.dart';

@JsonSerializable()
class FbTime {
  @JsonKey(name: '_seconds')
  final int seconds;
  @JsonKey(name: '_nanoseconds')
  final int nanoseconds;

  FbTime(this.seconds, this.nanoseconds);

  DateTime get time => DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  factory FbTime.fromJson(Map<String, dynamic> json) => _$FbTimeFromJson(json);
}