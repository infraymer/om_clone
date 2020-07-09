import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/match_screen.dart';
import 'package:tinder/view_model/selection_controller.dart';
import 'package:tinder/widgets/no_button.dart';
import 'package:tinder/widgets/swipeable_tinder_card.dart';
import 'package:tinder/widgets/tinder_card_content.dart';
import 'package:tinder/widgets/yes_button.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectionController>(
      init: SelectionController(),
      initState: (_) => Get.put(SelectionController()),
      builder: (_) {
        return Obx(
          () => SelectionController.to.matchUser.value == null
              ? _ThisScreen()
              : MatchScreen(matchUser: SelectionController.to.matchUser.value),
        );
      },
    );
  }
}

class _ThisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _Loading(),
              _Error(),
            ],
          ),
          _OmCards(),
          _Buttons(),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPumpingHeart(
        color: Colors.white,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<SelectionController>(
        builder: (_) => Container(
              margin: EdgeInsets.fromLTRB(60, 16, 60, 0),
              child: Text(
                _?.errorMessage?.value ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ));
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.find<SelectionController>();
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
                onTap: () async {
                  model.like();
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
    return GetX<SelectionController>(
      builder: (model) {
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
                    // Navigator.push(context, MatchRoute(model.users[0]));
                    model.like();
                  }
                },
              ),
          ],
        );
      },
    );
  }
}
