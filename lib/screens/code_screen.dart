import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/base_screen.dart';
import 'package:tinder/widgets/app_back_button.dart';
import 'package:tinder/widgets/app_button.dart';
import 'package:tinder/widgets/custom_app_bar_1.dart';
import 'package:tinder/widgets/pincode/models/pin_theme.dart';
import 'package:tinder/widgets/pincode/pin_code_fields_custom.dart';

class CodeScreen extends StatelessWidget {
  final style = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  final fieldDecoration = BoxDecoration(
    color: AppColors.textField,
    borderRadius: BorderRadius.circular(4),
  );

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: CustomAppBar1(
        textTitle: Strings.phoneTitle,
        leading: AppBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildPhone(),
            SizedBox(height: 40),
            _buildCode(),
            SizedBox(height: 32),
            _buildButton(context),
            SizedBox(height: 20),
            _buildNoCodeButton(),
            SizedBox(height: 20),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      Strings.welcomeDescription,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AppButton(
        text: Strings.next,
        onPressed: () => Navigator.push(context, RegistrationRoute()),
      ),
    );
  }

  Widget _buildPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.edit, size: 18), Text('+79006557893')],
    );
  }

  Widget _buildCode() {
    return PinCodeTextField(
      length: 6,
      obsecureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        selectedColor: AppColors.main,
        selectedFillColor: AppColors.textField,
        inactiveColor: AppColors.textField,
        inactiveFillColor: AppColors.textField,
        activeColor: AppColors.textField,
        activeFillColor: AppColors.textField,
        borderRadius: BorderRadius.circular(4),
        fieldHeight: 40,
        fieldWidth: 40,
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      animationDuration: Duration(milliseconds: 150),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }

  Widget _buildNoCodeButton() {
    return FlatButton(
      child: Text(Strings.loginCreateAccount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )),
      onPressed: () {},
    );
  }
}
