import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tinder/constants.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/utils/view_utils.dart';
import 'package:tinder/view_model/registration_view_model.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/pincode/models/pin_theme.dart';
import 'package:tinder/widgets/pincode/pin_code_fields_custom.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class BirthdayScreen extends StatefulWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const BirthdayScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final _birthdayController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegistrationViewModel>(context, listen: false);
    return ScreenContainer(
      keyScaffold: _scaffoldKey,
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: widget.onBackClicked,
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
            margin: EdgeInsets.symmetric(
                horizontal: Dimens.horizontalMarginButtonRegScreen),
            child: AppRoundFilledButton(
              onPressed: () {
                final text = _birthdayController.text;
                final rp = RegExp(Constants.dateRexExp);
                if (!rp.hasMatch(text)) {
                  showMessage(_scaffoldKey, 'Incorrect date');
                  return;
                }
                final date = _codeToDate(text);
                model.birthday = DateFormat('dd-MM-yyyy').parse(date);
                widget.onActionClicked();
              },
              text: Strings.next,
            ),
          ),
          SizedBox(height: Dimens.bottomMarginButtonRegScreen),
        ],
      ),
    );
  }

  String _codeToDate(String text) {
    final dd = text.substring(0, 2);
    final mm = text.substring(2, 4);
    final yyyy = text.substring(4, 8);
    return '$dd-$mm-$yyyy';
  }

  Widget _buildCode(BuildContext context) {
    return PinCodeTextField(
      length: 8,
      obsecureText: false,
      animationType: AnimationType.fade,
      controller: _birthdayController,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.underline,
        selectedColor: AppColors.main,
        inactiveColor: AppColors.textField,
        activeColor: AppColors.textField,
        fieldHeight: 30,
        fieldWidth: 24,
        borderWidth: 4,
      ),
      textInputType: TextInputType.number,
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
