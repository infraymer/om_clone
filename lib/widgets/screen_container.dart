import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const ScreenContainer({Key key, this.child, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
