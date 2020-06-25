import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/view_model/auth_view_model.dart';
import 'package:tinder/view_model/selection_view_model.dart';
import 'package:tinder/widgets/no_button.dart';
import 'package:tinder/widgets/swipeable_tinder_card.dart';
import 'package:tinder/widgets/tinder_card_content.dart';
import 'package:tinder/widgets/yes_button.dart';

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen>
    with TickerProviderStateMixin {
  var size = 0;
  var sizeTwo = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Stack(
        children: <Widget>[
          _OmCards(),
          _Buttons(),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SelectionViewModel>(context, listen: false);
    return Positioned(
      bottom: 20,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Opacity(
            opacity: 0,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.transparent),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NoButton(
                onTap: () {
                  model.dislike();
                },
              ),
              SizedBox(width: 20),
              YesButton(
                count: 70,
                onTap: () async {
                  model.like().then((matchUser) {
                    if (matchUser == null) return;
                    Navigator.push(context, MatchRoute(matchUser));
                  });
                },
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () => Navigator.push(context, SettingsRoute()),
          ),
        ],
      ),
    );
  }
}


class _OmCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SelectionViewModel>();
    return Stack(
      children: <Widget>[
        if (model.users.length > 1)
          SwipeableCard(
            key: UniqueKey(),
            child: TinderCardContent(
              data: model.users[1],
            ),
          ),
        if (model.users.length > 0)
          SwipeableCard(
            key: UniqueKey(),
            child: TinderCardContent(
              data: model.users[0],
            ),
            callback: (SwipeDirection swipe, child) {
              if (swipe == SwipeDirection.LEFT) {
                model.dislike();
              } else {
                model.like().then((matchUser) {
                  if (matchUser == null) return;
                  Navigator.push(context, MatchRoute(matchUser));
                });
              }
            },
          ),
      ],
    );
  }
}
