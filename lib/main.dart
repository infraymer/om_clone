import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/screens/auth_screen.dart';
import 'package:tinder/view_model/auth_view_model.dart';
import 'package:tinder/view_model/selection_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => SelectionViewModel()),
      ],
      child: GetMaterialApp(
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
      ),
    );
  }
}
