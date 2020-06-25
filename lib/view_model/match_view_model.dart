import 'package:flutter/material.dart';
import 'package:tinder/model/user.dart';

class MatchViewModel extends ChangeNotifier {
  User matchUser;
  User me;

  MatchViewModel(this.matchUser, this.me);

}
