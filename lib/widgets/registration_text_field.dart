import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';

class RegistrationTextField extends StatelessWidget {
  final String hint;

  const RegistrationTextField({Key key, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
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
