// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    json['uid'] as String,
    json['toUid'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['text'] as String,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'uid': instance.userId,
      'toUid': instance.toUid,
      'date': instance.date?.toIso8601String(),
      'text': instance.text,
    };
