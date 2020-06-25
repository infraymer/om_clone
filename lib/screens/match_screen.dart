import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tinder/constants.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/profile_screen.dart';
import 'package:tinder/view_model/match_view_model.dart';
import 'package:tinder/widgets/app_icon_round_button_dark.dart';
import 'package:tinder/widgets/match_photo.dart';
import 'package:tinder/widgets/screen_container.dart';
import 'package:dartx/dartx.dart';

class MatchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MatchViewModel>(context);

    // todo Сделать логику экрана MATCH

    return ScreenContainer(
      backgroundColor: AppColors.main,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(Strings.matchTitle, style: TextStyles.matchTitle),
          SizedBox(height: 20),
          Text('You and ${model.matchUser.name} have liked each other', style: TextStyles.matchSubtitle),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  MatchPhoto(model.me.imgs.firstOrNull),
                  SizedBox(width: 100),
                  Hero(
                    tag: model.matchUser.uid,
                    child: MatchPhoto(model.matchUser.imgs.firstOrNull),
                  ),
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
            onPressed: () => Navigator.pop(context),
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
