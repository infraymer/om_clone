import 'package:flutter/material.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/widgets/app_round_button.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/registration_text_field.dart';
import 'package:tinder/widgets/screen_container.dart';

class AboutScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const AboutScreen({Key key, this.onActionClicked, this.onBackClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.aboutTitle,
            titlePadding: const EdgeInsets.symmetric(horizontal: 40),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: RegistrationTextField(
              hint: Strings.aboutFieldPlaceholder,
            ),
          ),
          SizedBox(height: 16),
          Text(Strings.aboutDescription, style: TextStyles.fieldDescription),
          Expanded(child: SizedBox()),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: AppRoundButton(
              onPressed: onActionClicked,
              text: Strings.skip,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
