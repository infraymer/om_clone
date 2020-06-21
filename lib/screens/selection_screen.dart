import 'package:flutter/material.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/profile_screen.dart';
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
    final cards = loadCards();
    size = cards.length;
    return Scaffold(
      backgroundColor: AppColors.main,
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () => Navigator.push(context, SettingsRoute()),
//          ),
//        ],
//      ),
      body: Stack(
        children: <Widget>[
          LayoutBuilder(builder: (context, constrains) {
            return CardStack(
              key: UniqueKey(),
              cards: cards.sublist(0, sizeTwo),
              height: constrains.maxHeight,
              width: constrains.maxWidth,
            );
          }),
          Positioned(
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
                        sizeTwo--;
                        if (sizeTwo < 1) {
                          sizeTwo = 4;
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(width: 20),
                    YesButton(
                      count: 70,
                      onTap: () => Navigator.push(context, MatchRoute()),
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
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  List<SwipeableCard> loadCards() {
    return images.map((index) => _buildCard(index)).toList();
  }

  SwipeableCard _buildCard(String image) {
    return SwipeableCard(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, FadePageRoue(ProfileScreen(tag: image)));
        },
        child: TinderCardContent(image: image),
      ),
      callback: (result, card) {
        sizeTwo--;
        if (sizeTwo < 1) {
          sizeTwo = 4;
          setState(() {});
        }
        print("User swiped " + result.toString() + " on " + card.toString());
      },
    );
  }

  var allImage = [];

  final images = [
    'https://avatars.mds.yandex.net/get-pdb/1893235/721e847f-a920-477e-ae18-3b531f31aca8/s1200?webp=false',
    'https://avatars.mds.yandex.net/get-zen_doc/50509/pub_5d544987ac412400acfeb5fa_5d544ffa35c8d800ae97eeb9/scale_1200',
    'https://avatars.mds.yandex.net/get-pdb/1938028/9db2f4c2-8865-4ea3-8df3-b60568631789/s1200?webp=false',
    'https://avatars.mds.yandex.net/get-pdb/881477/e830eaaa-ea2e-4ead-9b50-fa14afb87f73/s1200?webp=false'
  ];
}
