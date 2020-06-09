import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget appBar;
  final Widget body;

  const BaseScreen({Key key, this.appBar, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            appBar,
            Expanded(
              child: body,
            )
          ],
        ),
      ),
    );
  }
}
