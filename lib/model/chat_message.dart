import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  @JsonKey(name: 'uid')
  final String userId;
  final String toUid;
  final DateTime date;
  final String text;

  ChatMessage(this.userId, this.toUid, this.date, this.text);

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}