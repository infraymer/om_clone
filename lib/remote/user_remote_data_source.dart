import 'package:firebase_database/firebase_database.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/model/user_create.dart';
import 'package:tinder/remote/api.dart';

class UserRemoteDataSource {
  Future<void> createUser(UserCreate data) async {
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

  Future<User> getUser(String userId) async {
    final result = await dio.get('user', queryParameters: {'uid': userId});
    final data = User.fromJson(result.data);
    return data;
  }

  Future<void> updateUser(User user) async {
    final result = await dio.post('updateUser', data: user.toJson());
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
