import 'package:tinder/model/chat_message.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/chat_remote_data_source.dart';

class ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource = ChatRemoteDataSource();

  Future<List<ChatMessage>> getMessages(User matchUser, User owner, [DateTime date]) async {
    final messages = await _chatRemoteDataSource.getMessages(matchUser.uid, date: date);
    messages.where((element) => element.toUid == matchUser.uid || element.toUid == matchUser.uid).toList();
    return messages;
  }

  Future<ChatMessage> sendMessage(String userId, String text) =>
      _chatRemoteDataSource.sendMessage(userId, text);

  Stream<DateTime> newMessageListener(String matchUserId) =>
      _chatRemoteDataSource.newMessageListener(matchUserId);
}