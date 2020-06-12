import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/widgets/app_round_button.dart';
import 'package:tinder/widgets/pincode/models/pin_theme.dart';
import 'package:tinder/widgets/pincode/pin_code_fields_custom.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class BirthdayScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const BirthdayScreen({Key key, this.onActionClicked, this.onBackClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.birthdayTitle,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: _buildCode(),
          ),
          Text(Strings.birthdayDescription, style: TextStyles.fieldDescription),
          SizedBox(height: 60),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: AppRoundButton(
              onPressed: onActionClicked,
              text: Strings.continueText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCode() {
    return PinCodeTextField(
      length: 8,
      obsecureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.underline,
        selectedColor: AppColors.main,
        inactiveColor: AppColors.textField,
        activeColor: AppColors.textField,
        fieldHeight: 30,
        fieldWidth: 24,
        borderWidth: 4,
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      textStyle: TextStyle(fontSize: 14),
      addWidgets: (widgets) {
        widgets.insert(4, Text('/'));
        widgets.insert(2, Text('/'));
        return widgets;
      },
      animationDuration: Duration(milliseconds: 150),
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
    );
  }
}
