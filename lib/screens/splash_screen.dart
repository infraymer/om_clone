import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/images.dart';

class SplashScreen extends StatelessWidget {
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
              child: SvgPicture.asset(AppImages.logoWithTitleWhite),
            ),
            SizedBox(height: 60),
            Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
