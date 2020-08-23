import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/view_model/selection_controller.dart';
import 'package:tinder/widgets/app_round_button_dark.dart';
import 'package:tinder/widgets/logo_title_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.main,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70),
              child: LogoTitleWidget(),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                Strings.loginDescription,
                textAlign: TextAlign.center,
                style: UiTextStyles.loginDescription,
              ),
            ),
            SizedBox(height: 20),
            FlatButton(
              child: Text(Strings.loginCreateAccount,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  )),
              onPressed: () => Navigator.push(context, PhoneRoute()),
            ),
            SizedBox(height: 20),
            AppRoundButtonDark(
              margin: EdgeInsets.symmetric(horizontal: 50),
              text: Strings.loginPhone,
              onPressed: () => Navigator.push(context, PhoneRoute()),
            ),
            SizedBox(height: 20),
            GestureDetector(
              // onTap: () => Navigator.pushReplacement(context, SelectionRoute()),
              child: Text(Strings.loginTrouble,
                  style: UiTextStyles.loginDescription),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
