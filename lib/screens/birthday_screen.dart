import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/view_model/registration_view_model.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/pincode/models/pin_theme.dart';
import 'package:tinder/widgets/pincode/pin_code_fields_custom.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class BirthdayScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const BirthdayScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

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
            child: _buildCode(context),
          ),
          Text(Strings.birthdayDescription, style: TextStyles.fieldDescription),
          Expanded(child: SizedBox()),
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

  Widget _buildCode(BuildContext context) {
    final model = Provider.of<RegistrationViewModel>(context);
    return PinCodeTextField(
      length: 8,
      obsecureText: false,
      animationType: AnimationType.fade,
      controller: model.birthdayController,
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
