import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class UiTextStyles {
  static final registrationTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static final fieldDescription = TextStyle(
    fontSize: 14,
    color: AppColors.icon,
  );

  static final photoDescription = TextStyle(
    fontSize: 12,
    color: AppColors.icon,
  );

  static final loginDescription = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );

  static const welcomeTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const matchTitle = TextStyle(
    fontFamily: 'Segoe Print',
    fontSize: 50,
    color: Colors.white,
  );

  static const matchSubtitle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
