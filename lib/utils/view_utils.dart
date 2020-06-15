import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder/utils/auth_firebase.dart';

showMessage(GlobalKey<ScaffoldState> keyScaffold, String text) {
  keyScaffold.currentState.showSnackBar(
    customSnack(text)
  );
}