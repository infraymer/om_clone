import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tinder/cache/chat_cache_data_source.dart';
import 'package:tinder/location/domain/interactor/location_interactor.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/remote/user_remote_data_source.dart';
import 'package:tinder/utils/dialogs.dart';
import 'package:tinder/view_model/loading_controller.dart';

enum AuthState { splash, login, registration, home }

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final _userRemoteDataSource = UserRemoteDataSource();
  final _chatCacheDataSource = ChatCacheDataSource();
  final LocationInteractor _locationInteractor = LocationInteractor();

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
      if (!auth) {
        authState.value = AuthState.login;
        return;
      }
      profile = await _userRemoteDataSource.me();
      await Future.delayed(Duration(seconds: 2));
      authState.value = AuthState.home;
      _locationInteractor.getCurrentLocation();
//      final matchUser = await _chatCacheDataSource.getActiveChat();
//      if (matchUser != null) Get.to(ChatScreen(user: matchUser));
    } catch (e) {
      final dioError = e is DioError ? e as DioError : null;

      print(e);

      if (dioError != null && dioError.response.statusCode == 404) {
        authState.value = AuthState.registration;
        return;
      }

      //throws when there is no user in database
      if (dioError != null && dioError.response.statusCode == 400) {
        authState.value = AuthState.registration;
        return;
      }
      authState.value = AuthState.login;
    }
  }

  Future<bool> get isAuth async {
    final user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
    authState.value = AuthState.login;
  }

  Future<void> removeUser() async {
    try {
      UiDialogs.showProgressDialog();
      LoadingController.to.isLoading.value = true;
      await _userRemoteDataSource.removeUser();
      await FirebaseAuth.instance.signOut();
      authState.value = AuthState.login;
    } catch (e) {
      Get.snackbar('', 'Error remove account');
      print(e);
    } finally {
      Get.back();
    }
  }
}
