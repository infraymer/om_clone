import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder/remote/chat_remote_data_source.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/screens/auth_screen.dart';
import 'package:tinder/view_model/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController());
  
  // ChatRemoteDataSource().sendMessage('7620b70a-15d2-5cc6-ab37-95bbcc65ba83', 'Hello world');
  ChatRemoteDataSource().getMessages();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
