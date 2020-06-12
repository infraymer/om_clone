import 'package:flutter/material.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/widgets/registration_icon_button.dart';

class RegistrationAppBar extends StatelessWidget {
  final VoidCallback onIconPressed;
  final String title;
  final IconData icon;
  final EdgeInsetsGeometry titlePadding;
  final bool centerTitle;

  const RegistrationAppBar({Key key, this.onIconPressed, this.title, this.icon, this.titlePadding, this.centerTitle = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: RegistrationIconButton(
            onPressed: onIconPressed,
            icon: icon ?? Icons.close,
          ),
        ),
        Align(
          alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
          child: Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            child: Padding(
              padding: titlePadding ?? const EdgeInsets.symmetric(horizontal: 60),
              child: Text(title, style: TextStyles.registrationTitle),
            ),
          ),
        ),
      ],
    );
  }
}
