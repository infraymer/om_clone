import 'package:tinder/remote/api.dart';

class ChatRemoteDataSource {
  Future<void> getMessages() async {
    final result = await dio.get('messages');
    print(result.data);
  }

  Future<void> sendMessage(String userId, String text) async {
    final result = await dio.post('sendMessage', data: {
      'uid': userId,
      'text': text,
    });
    print(result.data);
  }
}
