import 'package:tinder/model/chat_message.dart';
import 'package:tinder/remote/api.dart';

class ChatRemoteDataSource {
  Future<List<ChatMessage>> getMessages() async {
    final result = await dio.get('messages');
    final list = result.data as List;
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
}
