import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/screens/base_screen.dart';
import 'package:tinder/widgets/app_back_button.dart';
import 'package:tinder/widgets/app_button.dart';
import 'package:tinder/widgets/custom_app_bar_1.dart';

class PhoneScreen extends StatelessWidget {
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
          onPressed: () {},
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTitle(),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                _buildCountryField(),
                SizedBox(width: 16),
                _buildPhoneField(),
              ],
            ),
            SizedBox(height: 24),
            _buildDescription(),
            SizedBox(height: 32),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      Strings.phoneEnterYourMobile,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildCountryField() {
    return Container(
      decoration: fieldDecoration,
      child: Row(
        children: <Widget>[
          CountryCodePicker(
            onChanged: print,
            textStyle: style,
            initialSelection: 'US',
            flagWidth: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: fieldDecoration,
        child: TextField(
          style: style,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
          ],
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      Strings.phoneDescription,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      child: AppButton(
        text: Strings.next,
        onPressed: () {},
      ),
    );
  }
}
