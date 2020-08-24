import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder/widgets/om_loading.dart';

class UiDialogs {
  static void showMenuDialog(Map<String, Function> menu) {
    Get.bottomSheet(
      ListView(
        shrinkWrap: true,
        children: menu.keys
            .map((e) => ListTile(
                  title: Text(e.toString()),
                  onTap: () {
                    menu[e]?.call();
                    Get.back();
                  },
                ))
            .toList(),
      ),
      backgroundColor: Colors.white,
    );
  }

  static void showPhotoActionDialog({Function onSelect, Function onRemove}) {
    UiDialogs.showMenuDialog({
      'Select photo': onSelect,
      'Remove': onRemove,
    });
  }

  static void showProgressDialog() {
    Get.dialog(
      Container(
        color: Colors.black12,
        child: OmLoading(white: true),
      ),
    );
  }
}
