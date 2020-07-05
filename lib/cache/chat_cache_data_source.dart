import 'dart:convert';

import 'package:tinder/main.dart';
import 'package:tinder/model/user.dart';

class ChatCacheDataSource {
  static const _matchUserId = 'matchUserId';

  Future<void> setActiveChat(User matchUser) async {
    if (matchUser == null)
      await storage.write(_matchUserId, null);
    else
      await storage.write(_matchUserId, jsonEncode(matchUser.toJson()));
  }

  Future<User> getActiveChat() async {
    final json = storage.read(_matchUserId);
    if (json == null) return null;
    return User.fromJson(jsonDecode(json));
  }
}