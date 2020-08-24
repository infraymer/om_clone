import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tinder/model/chat_message.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';
import 'package:tinder/repository/chat_repository.dart';
import 'package:tinder/view_model/auth_controller.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  final _chatRepository = ChatRepository();
  final _userRemoteDataSource = UserRemoteDataSource();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final isSendLoading = false.obs;
  final Rx<User> user = Rx<User>(null);
  final inputMessage = ''.obs;

  get profile => AuthController.to.profile;

  final ScrollController scrollController = ScrollController();

  StreamSubscription _updateMessagesSub;

  ChatController(User user) {
    this.user.value = user;
    getMessages();
  }

  Future<void> getMessages() async {
    _chatRepository.setActiveChat(user.value);
    try {
      isLoading.value = true;
      final msgs = await _chatRepository.getMessages(user.value, profile);
      final sort = msgs.sortedBy((element) => element.date).reversed.toList();
      messages.value = sort;
    } catch (e) {
      Get.snackbar('', 'Messages loading error');
    } finally {
      isLoading.value = false;
    }

    _updateMessagesSub?.cancel();
    _updateMessagesSub =
        _chatRepository.newMessageListener(profile.uid).listen((date) {
      addNewMessages(date.add(Duration(seconds: -10)));
    });
  }

  Future<void> sendMessage() async {
    if (inputMessage.value.trim().isEmpty) return;
    try {
      var newMsg = ChatMessage(
          profile.uid, user.value.uid, DateTime.now(), inputMessage.value);
      inputMessage.value = '';
      messages.insert(0, newMsg);
      scrollToBottom();
      _chatRepository
          .sendMessage(
        user.value.uid,
        newMsg.text,
      )
          .then((value) {
        /// Сообщение успешно посланно
        /// можно ставить индикатор "отправленно"
      });
    } catch (e) {
      /// Ошибка отправки сообщения
      /// нужно пометить сообщение "ошибка отправки"
      Get.snackbar('', 'Message not send');
    }
    /*
    if (inputMessage.value.trim().isEmpty) return;
    try {
      isSendLoading.value = true;
      final msg = await _chatRepository.sendMessage(
        user.value.uid,
        inputMessage.value,
      );
      inputMessage.value = '';
      messages.insert(0, msg);
      scrollToBottom();
    } catch (e) {
      Get.snackbar('', 'Message not send');
    } finally {
      isSendLoading.value = false;
    }
     */
  }

  Future<void> addNewMessages(DateTime date) async {
    try {
      final msgs = await _chatRepository.getMessages(user.value, profile, date);
      print(msgs);
      final sort = msgs.sortedBy((element) => element.date).reversed.toList();
      messages.insertAll(0, sort);
    } catch (e) {}
  }

  scrollToBottom() {
    scrollController.animateTo(
      0.0,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 1),
    );
  }

  onBackClicked() {
    _chatRepository.setActiveChat(null);
  }

  @override
  void onClose() {
    _chatRepository.setActiveChat(null);
    _updateMessagesSub?.cancel();
    super.onClose();
  }
}
