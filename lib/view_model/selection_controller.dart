import 'dart:async';

import 'package:get/get.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';

class SelectionController extends GetxController {
  static SelectionController get to => Get.find();
  final _userRemoteDataSource = UserRemoteDataSource();

  RxList<User> users = <User>[].obs;
  final errorMessage = ''.obs;

  bool _disposed = false;

  SelectionController() {
    getFeeds();
    users.listen((_) {
      if (users.length < 2) getFeeds();
    });
  }

  Future<void> getFeeds() async {
    try {
      final list = await _userRemoteDataSource.getFeeds();
      users.addAll(list);
      errorMessage.value = '';
    } catch (e) {
      if (_disposed) return;
      errorMessage.value = 'Fetch feeds error. We sent the request again.';
      await Future.delayed(Duration(seconds: 10));
      getFeeds();
    }
  }

  Future<void> dislike() async {
    if (users.isEmpty) return;
    final user = users.first;
    users.removeAt(0);
    await _userRemoteDataSource.like(user.uid, false);
  }

  Future<User> like() async {
    if (users.isEmpty) return null;
    final user = users.first;
    users.removeAt(0);
    await _userRemoteDataSource.like(user.uid, true);
    return user;
  }

  @override
  void onClose() {
    _disposed = true;
    super.onClose();
  }
}
