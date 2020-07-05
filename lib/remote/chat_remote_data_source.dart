import 'package:firebase_database/firebase_database.dart';
import 'package:tinder/model/chat_message.dart';
import 'package:tinder/remote/api.dart';

class ChatRemoteDataSource {
  Future<List<ChatMessage>> getMessages(String userId, {DateTime date}) async {
    final result = await dio.get('messages', queryParameters: {
      'uid': userId,
      'from': date?.toUtc()?.toIso8601String() ?? DateTime(2020).toIso8601String(),
    });
    final list = result.data['messages'] as List;
    final msgs = list.map((e) => ChatMessage.fromJson(e)).toList();
    return msgs;
  }

  Future<ChatMessage> sendMessage(String userId, String text) async {
    final result = await dio.post('sendMessage', data: {
      'uid': userId,
      'text': text,
    });
    return ChatMessage.fromJson(result.data);
  }

  Stream<DateTime> newMessageListener(String matchUserId) =>
      FirebaseDatabase.instance
          .reference()
          .child(matchUserId)
          .onValue
          .skip(1)
          .map((event) => DateTime.parse(event.snapshot.value['message']));
}
