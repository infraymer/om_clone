import 'package:flutter/material.dart';
import 'package:tinder/model/user.dart';

class MatchController extends ChangeNotifier {
  User matchUser;
  User me;

  MatchController(this.matchUser, this.me);

}
