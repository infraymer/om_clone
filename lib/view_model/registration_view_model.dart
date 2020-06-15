import 'dart:io';

import 'package:flutter/cupertino.dart';

class RegistrationViewModel extends ChangeNotifier {

  final nameController = TextEditingController();
  final birthdayController = TextEditingController();
  final schoolNameController = TextEditingController();
  bool genderMale = false;
  bool showMyGender = false;
  List<File> photos = List.generate(9, (index) => null);

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
}