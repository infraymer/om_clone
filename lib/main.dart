import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/screens/auth_screen.dart';
import 'package:tinder/view_model/auth_controller.dart';
import 'package:tinder/view_model/selection_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController());
  Get.put(SelectionController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
