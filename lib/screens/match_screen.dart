import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/view_model/match_controller.dart';
import 'package:tinder/widgets/app_icon_round_button_dark.dart';
import 'package:tinder/widgets/match_photo.dart';
import 'package:tinder/widgets/screen_container.dart';

class MatchScreen extends StatelessWidget {
  final User matchUser;

  const MatchScreen({Key key, @required this.matchUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchController>(
      init: MatchController(matchUser),
      builder: (_) {
        return ScreenContainer(
          backgroundColor: AppColors.main,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(Strings.matchTitle, style: TextStyles.matchTitle),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('You and ${_.matchUser.name} have liked each other',
                    textAlign: TextAlign.center,
                    style: TextStyles.matchSubtitle),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: FittedBox(
                  child: Row(
                    children: <Widget>[
                      MatchPhoto(_.me.imgs?.firstOrNull),
                      SizedBox(width: 100),
                      MatchPhoto(_.matchUser.imgs?.firstOrNull),
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              AppIconRoundButtonDark(
                margin: EdgeInsets.symmetric(horizontal: 50),
                text: Strings.matchSendMessage,
                icon: Icons.chat_bubble,
                onPressed: () => Navigator.push(context, ChatRoute(_.matchUser)),
              ),
              SizedBox(height: 30),
              AppIconRoundButtonDark(
                margin: EdgeInsets.symmetric(horizontal: 50),
                text: Strings.matchKeepPlaying,
                icon: Icons.perm_contact_calendar,
                onPressed: () => _.onContinueMatch(),
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
      },
    );
  }
}
