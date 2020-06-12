import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class RegistrationIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const RegistrationIconButton({Key key, this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.icon,
        size: 40,
      ),
    );
  }
}
