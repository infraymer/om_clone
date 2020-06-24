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

  dislike() async {
    if (users.isEmpty) return;
    final user = users.first;
    await _userRemoteDataSource.like(user.uid, false);
    users.removeAt(0);
    notifyListeners();
  }

  like() async {
    if (users.isEmpty) return;
    final user = users.first;
    await _userRemoteDataSource.like(user.uid, true);
    users.removeAt(0);
    notifyListeners();
  }
}