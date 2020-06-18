import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/screens/chat_screen.dart';
import 'package:tinder/screens/profile_screen.dart';
import 'package:tinder/screens/selection_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        accentColor: AppColors.main,
        primaryColor: AppColors.main,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ProfileScreen(),
    );
  }
}
