import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:tinder/constants.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/screens/match_screen.dart';
import 'package:tinder/screens/settings_screen.dart';
import 'package:tinder/view_model/selection_controller.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/no_button.dart';
import 'package:tinder/widgets/rewind_button.dart';
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _Loading(),
                _Error(),
              ],
            ),
            _TopBar(),
            Obx(
              () => SelectionController.to.users.isNotEmpty
                  ? _OmCards()
                  : _NoMoreSwipes(),
            ),
            _Buttons(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share('Install OneMatch app!');
            },
          ),
          SvgPicture.asset(
            AppImages.logoDark,
            height: 32,
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () => Get.to(SettingsScreen()),
          ),
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
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NoButton(
                  onTap: () {
                    model.dislike();
                  },
                ),
                SizedBox(width: 20),
                RewindButton(
                  onTap: () => model.rewind(),
                  active: model.tempListUser.isNotEmpty,
                ),
                SizedBox(width: 20),
                YesButton(
                  onTap: () async {
                    model.like();
                  },
                ),
              ],
            ),
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

class _NoMoreSwipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Colors.grey,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.grey[300]),
              child: ClipRRect(
                child: Image.network(
                  Constants.womanImage,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width,
                ),
                borderRadius: BorderRadius.circular(500),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Spread the word!',
            style: UiTextStyles.title.copyWith(color: Colors.white),
          ),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: AppRoundFilledButton(
              light: true,
              onPressed: () {},
              text: 'Share',
            ),
          ),
        ],
      ),
    );
  }
}
