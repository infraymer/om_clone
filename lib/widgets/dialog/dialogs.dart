import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder/model/gender.dart';

class Dialogs {
  static showGenderDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Wrap(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                      title: Text('Man'),
                      onTap: () => Navigator.pop(context, Gender.man)),
                  ListTile(
                      title: Text('Woman'),
                      onTap: () => Navigator.pop(context, Gender.woman)),
                  ListTile(
                      title: Text('All'),
                      onTap: () => Navigator.pop(context, Gender.all)),
                ],
              )
            ],
          );
        });
  }

  static showBioDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                width: double.infinity,
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          );
        });
  }

  static showProgressDialog() {
    Get.dialog(
      Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
