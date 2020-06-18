import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tinder/constants.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/profile_screen.dart';
import 'package:tinder/widgets/app_icon_round_button_dark.dart';
import 'package:tinder/widgets/match_photo.dart';
import 'package:tinder/widgets/screen_container.dart';

class MatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      backgroundColor: AppColors.main,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(Strings.matchTitle, style: TextStyles.matchTitle),
          SizedBox(height: 20),
          Text(Strings.matchDescription, style: TextStyles.matchSubtitle),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: Constants.womanImage,
                    child: MatchPhoto(Constants.womanImage),
                  ),
                  SizedBox(width: 100),
                  MatchPhoto(Constants.manImage),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          AppIconRoundButtonDark(
            margin: EdgeInsets.symmetric(horizontal: 50),
            text: Strings.matchSendMessage,
            icon: Icons.chat_bubble,
            onPressed: () => Navigator.push(context, ChatRoute()),
          ),
          SizedBox(height: 30),
          AppIconRoundButtonDark(
            margin: EdgeInsets.symmetric(horizontal: 50),
            text: Strings.matchKeepPlaying,
            icon: Icons.perm_contact_calendar,
            // onPressed: () => Navigator.push(context, ProfileRoute(Constants.womanImage)),
            onPressed: () => Navigator.push(context, FadePageRoue(ProfileScreen(tag: Constants.womanImage))),
          ),
          SizedBox(height: 30),
          AppIconRoundButtonDark(
            margin: EdgeInsets.symmetric(horizontal: 50),
            text: Strings.matchTellYourFriends,
            icon: Icons.share,
            withBorder: false,
            onPressed: () {
              Share.share('Share OneMatch');
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
