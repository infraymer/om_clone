import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';

enum AuthState { splash, login, registration, home }

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final _userRemoteDataSource = UserRemoteDataSource();

  final authState = AuthState.splash.obs;

  User profile;

  @override
  void onInit() {
    checkAuth();
  }

  Future<void> checkAuth() async {
    authState.value = AuthState.splash;
    bool auth = false;
    try {
      auth = await isAuth;
      if (!auth) throw('no auth');
      profile = await _userRemoteDataSource.me();
      authState.value = AuthState.home;
    } catch (e) {
      authState.value = auth ? AuthState.registration : AuthState.login;
    }
  }

  Future<bool> get isAuth async {
    final user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    authState.value = AuthState.login;
  }
}