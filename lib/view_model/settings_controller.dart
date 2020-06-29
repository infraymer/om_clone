import 'package:get/get.dart';
import 'package:tinder/model/gender.dart';
import 'package:tinder/model/setting_filter.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';
import 'package:tinder/view_model/auth_controller.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();
  final _userRemoteDataSource = UserRemoteDataSource();

  User user;
  final isLoading = false.obs;
  String error;

  final minAge = 18.obs;
  final maxAge = 99.obs;
  final distance = 2.obs;
  final gender = Gender.all.obs;
  String about = '';

  @override
  void onInit() {
    _user = AuthController.to.profile;
    fetchData();
  }

  set _user(User value) {
    user = value;
    isLoading.value = false;
    error = null;

    final sf = value.settingFilter;
    minAge.value = sf?.ageMin ?? 18;
    maxAge.value = sf?.ageMax ?? 99;
    distance.value = sf?.maxDistance ?? 2;
    gender.value = sf?.gender?.toGender() ?? Gender.all;

    about = value.aboutMe ?? '';
  }

  setGender(Gender value) {
    gender.value = value;
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      _user = await _userRemoteDataSource.me();
    } catch (e) {
      Get.snackbar('', 'Error loading');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onDoneClicked() async {
    try {
      isLoading.value = true;
      final data = user.copyWith(
        aboutMe: about,
        settingFilter: SettingFilter(
          minAge.value,
          maxAge.value,
          gender.value.key,
          distance.value,
        ),
      );
      await _userRemoteDataSource.updateUser(data);
      AuthController.to.profile = data;
      Get.snackbar('Settings', 'Saved!',);
    } catch(e) {
      Get.snackbar('', 'Error update user');
    } finally {
      isLoading.value = false;
    }
  }
}
