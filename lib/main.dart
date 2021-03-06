import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder/push.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/screens/auth_screen.dart';
import 'package:tinder/screens/registration_screen.dart';
import 'package:tinder/view_model/auth_controller.dart';
import 'package:tinder/view_model/loading_controller.dart';
import 'package:tinder/widgets/loading_container.dart';

GetStorage storage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await GetStorage.init();
  storage = GetStorage();

  initFirebase();

  Get.put(LoadingController());
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        accentColor: AppColors.main,
        primaryColor: AppColors.main,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: AuthScreen(),
    );
  }
}
