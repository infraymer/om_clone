import 'package:flutter/material.dart';

class AppIconRoundButtonDark extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;
  final EdgeInsetsGeometry margin;
  final IconData icon;
  final bool withBorder;

  const AppIconRoundButtonDark({
    Key key,
    this.onPressed,
    this.text,
    this.isSelected = true,
    this.margin,
    this.icon,
    this.withBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      width: double.infinity,
      child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            side: BorderSide(color: withBorder ? Colors.white : Colors.transparent, width: 2),
          ),
          child: Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        icon,
                        color: Colors.white,
                      )),
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}
