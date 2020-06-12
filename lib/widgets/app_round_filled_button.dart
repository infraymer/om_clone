import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class AppRoundFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AppRoundFilledButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      onPressed: onPressed,
      color: AppColors.main,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
      ),
      highlightColor: Colors.white12,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
