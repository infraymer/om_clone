import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:tinder/view_model/chat_controller.dart';

import '../../routes.dart';
import '../profile_screen.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String heroTag;

  const UserAvatar({Key key, this.size = 50, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ChatController.to.user.value;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, FadePageRoue(ProfileScreen(user: data)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.black12)),
          child: Image.network(
            data.imgs.firstOrNull ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
