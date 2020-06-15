import 'package:tinder/model/user_create.dart';
import 'package:tinder/remote/api.dart';

class UserRemoteDataSource {
  Future<void> createUser(UserCreate data) async {
    await dio.post('updateUser', data: data.toMap());
  }
}