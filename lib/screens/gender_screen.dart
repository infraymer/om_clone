import 'package:flutter/material.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/about_screen.dart';
import 'package:tinder/widgets/app_round_button.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/checkbox_text.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class GenderScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const GenderScreen({Key key, this.onActionClicked, this.onBackClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.genderTitle,
          ),
          SizedBox(height: 80),
          _ToggleButtons(),
          Expanded(child: SizedBox()),
          Center(child: CheckBoxText(text: Strings.genderShowMyGender)),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: AppRoundFilledButton(
              onPressed: onActionClicked,
              text: Strings.genderGotIt,
            ),
          ),
          SizedBox(height: 30),
          // Text(Strings.birthdayDescription, style: TextStyles.fieldDescription),
        ],
      ),
    );
  }
}

class _ToggleButtons extends StatefulWidget {
  @override
  _ToggleButtonsState createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<_ToggleButtons> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: AppRoundButton(
            onPressed: () {
              selected = 0;
              setState(() {});
            },
            isSelected: selected == 0,
            text: Strings.genderWoman,
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: AppRoundButton(
            onPressed: () {
              selected = 1;
              setState(() {});
            },
            isSelected: selected == 1,
            text: Strings.genderMan,
          ),
        ),
      ],
    );
  }
}
