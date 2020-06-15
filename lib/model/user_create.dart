import 'package:intl/intl.dart';

class UserCreate {
  final String name;
  final String gender; // women or men
  final List<String> images;
  final bool showMyGender;
  final String aboutMe;
  final DateTime birthday; // 2020-06-01

  UserCreate(this.name, this.gender, this.images, this.showMyGender, this.aboutMe, this.birthday);

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'gender': this.gender,
      'imgs': this.images,
      'showMyGender': this.showMyGender,
      'aboutMe': this.aboutMe,
      'birthday': DateFormat('yyyy-MM-dd').format(birthday ?? DateTime.now()),
    };
  }
}