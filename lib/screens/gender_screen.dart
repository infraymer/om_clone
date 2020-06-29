import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/view_model/registration_controller.dart';
import 'package:tinder/widgets/app_round_button.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/checkbox_text.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class GenderScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const GenderScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

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
          Center(child: _ShowGenderCheckBox()),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMarginButtonRegScreen),
            child: AppRoundFilledButton(
              onPressed: onActionClicked,
              text: Strings.next,
            ),
          ),
          SizedBox(height: Dimens.bottomMarginButtonRegScreen),
        ],
      ),
    );
  }
}

class _ToggleButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegistrationController>();
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: AppRoundButton(
            onPressed: () {
              model.setGender(false);
            },
            isSelected: !model.genderMale,
            text: Strings.genderWoman,
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: AppRoundButton(
            onPressed: () {
              model.setGender(true);
            },
            isSelected: model.genderMale,
            text: Strings.genderMan,
          ),
        ),
      ],
    );
  }
}

class _ShowGenderCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegistrationController>();
    return CheckBoxText(
        text: Strings.genderShowMyGender,
        isChecked: model.showMyGender,
        onClicked: () {
          model.setShowMyGender();
        },
    );
  }
}

