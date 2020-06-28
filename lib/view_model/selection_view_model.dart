import 'package:flutter/cupertino.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';

class SelectionViewModel extends ChangeNotifier {
  final _userRemoteDataSource = UserRemoteDataSource();

  List<User> users = [];

  SelectionViewModel() {
    getFeeds();
  }

  Future<void> getFeeds() async {
    users = await _userRemoteDataSource.getFeeds();
    users.addAll(users.toList());
    notifyListeners();
  }

  Future<void> dislike() async {
    if (users.isEmpty) return;
    final user = users.first;
    users.removeAt(0);
    notifyListeners();
    await _userRemoteDataSource.like(user.uid, false);
  }

  Future<User> like() async {
    if (users.isEmpty) return null;
    final user = users.first;
    users.removeAt(0);
    notifyListeners();
    await _userRemoteDataSource.like(user.uid, true);
    return user;
  }
}