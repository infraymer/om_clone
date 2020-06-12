import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/screen_container.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(40, 50, 40, 30),
            child: SvgPicture.asset(AppImages.logoDark, width: 50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(Strings.welcomeTitle, style: TextStyles.welcomeTitle),
          ),
          SizedBox(height: 30),
          _DescriptionItem(title: Strings.welcomeTitle1, subtitle: Strings.welcomeSubtitle1),
          _DescriptionItem(title: Strings.welcomeTitle2, subtitle: Strings.welcomeSubtitle2),
          _DescriptionItem(title: Strings.welcomeTitle3, subtitle: Strings.welcomeSubtitle3),
          _DescriptionItem(title: Strings.welcomeTitle4, subtitle: Strings.welcomeSubtitle4),
          Expanded(child: SizedBox()),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: AppRoundFilledButton(
              onPressed: () => Navigator.push(context, MatchRoute()),
              text: Strings.genderGotIt,
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }
}

class _DescriptionItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DescriptionItem(
      {Key key, @required this.title, @required this.subtitle})
      : super(key: key);

  static const titleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const subtitleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: titleStyle),
          Text(subtitle, style: subtitleStyle),
        ],
      ),
    );
  }
}
