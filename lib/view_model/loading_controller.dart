import 'package:get/get.dart';

class LoadingController extends GetxController {
  static LoadingController get to => Get.find();
  final isLoading = false.obs;
}