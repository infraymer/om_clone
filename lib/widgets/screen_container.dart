import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState> keyScaffold;

  const ScreenContainer({Key key, this.child, this.backgroundColor, this.keyScaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
