import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class AppRoundButtonDark extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;
  final EdgeInsetsGeometry margin;

  const AppRoundButtonDark({Key key, this.onPressed, this.text, this.isSelected = true, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        onPressed: onPressed,
        color: Colors.transparent,
        highlightColor: Colors.white12,
        elevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
    );
  }
}
