import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class AppRoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  const AppRoundButton({Key key, this.onPressed, this.text, this.isSelected = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.main : AppColors.unselectedButton;
    final textColor = isSelected ? AppColors.main : AppColors.unselectedButtonText;
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      onPressed: onPressed,
      color: Colors.white,
      highlightColor: Colors.white12,
      splashColor: Colors.grey[100],
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: BorderSide(color: color, width: 2),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.w400, color: textColor),
      ),
    );
  }
}
