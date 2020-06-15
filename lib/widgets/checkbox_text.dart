import 'package:flutter/material.dart';

class CheckBoxText extends StatelessWidget {
  final Function onClicked;
  final String text;
  final bool isChecked;

  const CheckBoxText({Key key, this.onClicked, this.text, this.isChecked = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: isChecked,
            onChanged: (value) => onClicked?.call(),
          ),
          GestureDetector(
            child: Text(text ?? ''),
            onTap: () => onClicked?.call(),
          ),
        ],
      ),
    );
  }
}
