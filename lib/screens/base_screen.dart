import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final GlobalKey<ScaffoldState> keyScaffold;

  const BaseScreen({Key key, this.appBar, this.body, this.keyScaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      body: SafeArea(
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
