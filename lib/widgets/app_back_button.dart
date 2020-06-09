import 'package:flutter/material.dart';
import 'package:tinder/resources/strings.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBackButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        Strings.back,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}