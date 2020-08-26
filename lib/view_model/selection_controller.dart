import 'dart:async';

import 'package:get/get.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';
import 'package:tinder/view_model/auth_controller.dart';

class SelectionController extends GetxController {
  static SelectionController get to {
    try {
      return Get.find();
    } catch (e) {
      return null;
    }
  }

  final _userRemoteDataSource = UserRemoteDataSource();

  RxList<User> users = <User>[].obs;
  final bufferUsers = <User>[];
  final errorMessage = ''.obs;

  bool _disposed = false;

  StreamSubscription _matchSub;

  final Rx<User> matchUser = Rx<User>(null);
  final Rx<User> tempUser = Rx<User>(null);
  final RxList<User> tempListUser = RxList<User>([]);

  @override
  void onInit() {
    getFeeds(true);
    users.listen((_) {
      if (users.length < 2) getFeeds();

      if (users.length < 3 && bufferUsers.isNotEmpty) {
        users.addAll(bufferUsers);
        bufferUsers.clear();
      }
    });
    _matchSub = _userRemoteDataSource
        .matchListener(AuthController.to.profile.uid)
        .listen((event) {
      matchUser.value = event;
    }, onError: (e) {
      matchUser.value = null;
    });
  }

  Future<void> getFeeds([bool refresh = false]) async {
    try {
      if (refresh) users.value = [];
      final list = await _userRemoteDataSource.getFeeds();
      if (refresh) {
        users.value = list;
      } else {
        bufferUsers.addAll(list);
      }
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
    tempListUser.add(user);
    users.removeAt(0);
    final nextUser = await _userRemoteDataSource.like(user.uid, false);
    // users.add(nextUser)
    bufferUsers.add(nextUser);
  }

  Future<void> like() async {
    if (users.isEmpty) return null;
    final user = users.first;
    tempListUser.add(user);
    users.removeAt(0);

    if (user.isLike)
      matchUser.value = user;

    final nextUser = await _userRemoteDataSource.like(user.uid, true);
    // users.add(nextUser);
    bufferUsers.add(nextUser);
  }

  Future<void> rewind() async {
    if (tempListUser.isEmpty) return;
    users.insert(0, tempListUser.last);
    tempListUser.removeLast();
  }

  @override
  void onClose() {
    _matchSub?.cancel();
    _disposed = true;
    super.onClose();
  }
}
