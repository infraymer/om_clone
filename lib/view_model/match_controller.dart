import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';
import 'package:tinder/screens/auth_screen.dart';
import 'package:tinder/utils/dialogs.dart';
import 'package:tinder/view_model/auth_controller.dart';

class MatchController extends GetxController {
  final UserRemoteDataSource _userRemoteDataSource = UserRemoteDataSource();
  User matchUser;

  User get me => AuthController.to.profile;

  MatchController(this.matchUser);

  onContinueMatch() {
    Get.defaultDialog(
      title: 'Are you sure you want to unmatch with ${matchUser.name}?',
      content: SizedBox(),
      buttonColor: Colors.white,
      onConfirm: () async {
        Get..back();
        try {
          UiDialogs.showProgressDialog();
          await _userRemoteDataSource.cancelMatch(matchUser.uid);
          Get..back()..back()..back();
        } catch (e) {
          Get..back()..back()..back();
        }
      },
      onCancel: () {},
    );
  }
}
