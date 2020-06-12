import 'package:flutter/material.dart';

class CheckBoxText extends StatefulWidget {
  final Function(bool) onChecked;
  final String text;

  const CheckBoxText({Key key, this.onChecked, this.text}) : super(key: key);

  @override
  _CheckBoxTextState createState() => _CheckBoxTextState();
}

class _CheckBoxTextState extends State<CheckBoxText> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: isChecked,
            onChanged: (value) => _onChanged(),
          ),
          GestureDetector(
            child: Text(widget.text ?? ''),
            onTap: () => _onChanged(),
          ),
        ],
      ),
    );
  }

  void _onChanged() {
    isChecked = !isChecked;
    setState(() {});
    widget.onChecked?.call(isChecked);
  }
}
