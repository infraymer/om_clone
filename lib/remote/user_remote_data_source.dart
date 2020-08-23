import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/model/user_create.dart';
import 'package:tinder/push.dart';
import 'package:tinder/remote/api.dart';

class UserRemoteDataSource {
  Future<void> createUser(UserCreate data) async {
    final map = data.toMap();
    map['token'] = await firebaseMessaging.getToken();
    await dio.post('updateUser', data: data.toMap());
  }

  Future<List<User>> getFeeds() async {
    final result = await dio.get('feed');
    final list = result.data as List;
    final usrs = list.map((e) => User.fromJson(e)).toList();
    return usrs;
  }

  Future<User> like(String userId, bool like) async {
    final result = await dio.post('like', data: {
      'uid': userId,
      'like': like,
    });
    return User.fromJson(result.data);
  }

  Future<void> cancelMatch(String userId) async {
    final result = await dio.post('cancelMatch', data: {
      'uid': userId,
    });
    print('');
  }

  Future<User> me() async {
    final result = await dio.get('me');
    final data = User.fromJson(result.data);
    return data;
  }

  Future<void> removeUser() async {
    final result = await dio.post('removeUser');
  }

  Future<User> getUser(String userId) async {
    final result = await dio.get('user', queryParameters: {'uid': userId});
    final data = User.fromJson(result.data);
    return data;
  }

  Future<void> updateUser(User user) async {
    final token = await firebaseMessaging.getToken();
    final data = user.copyWith(token: token);
    final result = await dio.post('updateUser', data: data.toJson());
  }

  Stream<User> matchListener(String userId) =>
      FirebaseDatabase.instance
          .reference()
          .child(userId)
          .onValue
          .map((event) =>
      event.snapshot.value['match'])
          .where((event) =>
      event != null)
          .asyncMap((event) => getUser(event));

  Future<String> getMatchUserId(String userId) =>
      FirebaseDatabase.instance
          .reference()
          .child(userId)
          .once()
          .then((ss) => ss.value['match']);
}
