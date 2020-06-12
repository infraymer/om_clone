import 'package:flutter/material.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/widgets/app_round_button.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/registration_text_field.dart';
import 'package:tinder/widgets/screen_container.dart';

class NameScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const NameScreen({Key key, this.onActionClicked, this.onBackClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: onBackClicked,
            icon: Icons.close,
            title: Strings.nameTitle,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: RegistrationTextField(
              hint: Strings.nameFieldPlaceholder,
            ),
          ),
          SizedBox(height: 16),
          Text(Strings.nameDescription, style: TextStyles.fieldDescription),
          SizedBox(height: 40),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: AppRoundButton(
              onPressed: onActionClicked,
              text: Strings.next,
            ),
          ),
        ],
      ),
    );
  }
}
