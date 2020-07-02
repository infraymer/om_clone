import 'package:get/get.dart';
import 'package:dartx/dartx.dart';
import 'package:tinder/model/chat_message.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/chat_remote_data_source.dart';
import 'package:tinder/view_model/auth_controller.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  final _chatRemoteDataSource = ChatRemoteDataSource();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final Rx<User> user = Rx<User>(null);
  get profile => AuthController.to.profile;
  final inputMessage = ''.obs;

  Future<void> getMessages() async {
    try {
      isLoading.value = true;
      final msgs = await _chatRemoteDataSource.getMessages();
      final sort = msgs.sortedBy((element) => element.date).toList();
      messages.value = sort;
    } catch(e) {} finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    try {
      final msg = await _chatRemoteDataSource.sendMessage(user.value.uid, inputMessage.value);
      inputMessage.value = '';
      messages.add(msg);
    } catch(e) {
      Get.snackbar('', 'Error send message');
    }
  }
}