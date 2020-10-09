import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tinder/model/setting_filter.dart';
import 'package:tinder/model/user_create.dart';
import 'package:tinder/remote/file_remote_data_source.dart';
import 'package:tinder/remote/user_remote_data_source.dart';
import 'package:tinder/view_model/auth_controller.dart';

class RegistrationController extends ChangeNotifier {
  final _fileRemoteDataSource = FileRemoteDataSource();
  final _userRemoteDataSource = UserRemoteDataSource();

  final messageController = StreamController<String>();

  String name = '';
  DateTime birthday;
  String schoolName = 'about must not be empty';
  bool genderMale = false;
  bool showMyGender = false;
  List<File> photos = List.generate(9, (index) => null);

  bool isUploading = false;

  void setGender(bool male) {
    genderMale = male;
    notifyListeners();
  }

  void setShowMyGender() {
    showMyGender = !showMyGender;
    notifyListeners();
  }

  void setImage(int index, File file) {
    photos[index] = file;
    notifyListeners();
  }

  void swapImage(int oldIndex, int newIndex) {
    final e = photos[oldIndex];
    photos.removeAt(oldIndex);
    photos.insert(newIndex, e);
    notifyListeners();
  }

  Future<void> onDoneClicked() async {
    final images = await uploadImages();
    final gender = genderMale ? 'men' : 'women';
    final findGender = !genderMale ? 'men' : 'women';
    final data = UserCreate(
      name,
      gender,
      images,
      showMyGender,
      schoolName,
      birthday,
      SettingFilter(18, 99, findGender, 20),
    );
    await _userRemoteDataSource.createUser(data);
    AuthController.to.checkAuth();
  }

  Future<List<String>> uploadImages() async {
    final images = photos.where((element) => element != null).toList();
    final map =
        images.map((e) async => await _fileRemoteDataSource.uploadImage(e));
    final urls = await Future.wait(map);
    return urls;
  }

  @override
  void dispose() {
    messageController.close();
    super.dispose();
  }
}
