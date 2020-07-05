import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tinder/model/chat_message.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/repository/chat_repository.dart';
import 'package:tinder/view_model/auth_controller.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  final _chatRepository = ChatRepository();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final isSendLoading = false.obs;
  final Rx<User> user = Rx<User>(null);
  final inputMessage = ''.obs;

  get profile => AuthController.to.profile;

  final ScrollController scrollController = ScrollController();

  StreamSubscription _updateMessagesSub;

  Future<void> getMessages() async {
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
    _updateMessagesSub = _chatRepository.newMessageListener(user.value.uid).listen((date) {
      addNewMessages(date);
    });
  }

  Future<void> sendMessage() async {
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
  }

  Future<void> addNewMessages(DateTime date) async {
    try {
      final msgs = await _chatRepository.getMessages(user.value, profile, date);
      final sort = msgs.sortedBy((element) => element.date).reversed.toList();
      messages.addAll(sort);
    } catch (e) {}
  }

  scrollToBottom() {
    scrollController.animateTo(
      0.0,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 1),
    );
  }

  @override
  void onClose() {
    _updateMessagesSub?.cancel();
    super.onClose();
  }
}
