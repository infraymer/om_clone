import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class RegistrationTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final Function(String) onSubmitted;

  const RegistrationTextField({Key key, this.hint, this.controller, this.textInputAction, this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
        Container(
          height: 3,
          color: AppColors.icon,
        )
      ],
    );
  }
}
