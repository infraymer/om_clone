import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/widgets/swipeable_tinder_card.dart';
import 'package:tinder/widgets/tinder_card_content.dart';

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen>
    with TickerProviderStateMixin {
  var size = 0;

  @override
  Widget build(BuildContext context) {
    final cards = loadCards();
    size = cards.length;
    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: LayoutBuilder(builder: (context, constrains) {
              return CardStack(
                key: UniqueKey(),
                cards: cards,
                height: constrains.maxHeight,
                width: constrains.maxWidth,
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _NoButton(),
              SizedBox(width: 20),
              _YesButton(),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  List<SwipeableCard> loadCards() {
    return images.map((index) => _buildCard(index)).toList();
  }

  SwipeableCard _buildCard(String image) {
    return SwipeableCard(
      child: TinderCardContent(image: image),
      callback: (result, card) {
        size--;
        if (size < 1) {
          setState(() {});
        }
        print("User swiped " + result.toString() + " on " + card.toString());
      },
    );
  }

  final images = [
    'https://avatars.mds.yandex.net/get-pdb/1893235/721e847f-a920-477e-ae18-3b531f31aca8/s1200?webp=false',
    'https://avatars.mds.yandex.net/get-zen_doc/50509/pub_5d544987ac412400acfeb5fa_5d544ffa35c8d800ae97eeb9/scale_1200',
    'https://avatars.mds.yandex.net/get-pdb/1938028/9db2f4c2-8865-4ea3-8df3-b60568631789/s1200?webp=false',
    'https://avatars.mds.yandex.net/get-pdb/881477/e830eaaa-ea2e-4ead-9b50-fa14afb87f73/s1200?webp=false'
  ];
}

class _NoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(100);
    final double size = 50;
    return ClipRRect(
      borderRadius: radius,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.black38,
          child: Container(
            height: size,
            width: size,
            child: Center(
              child: SvgPicture.asset(
                AppImages.close,
                width: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _YesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(100);
    final double size = 50;
    return ClipRRect(
      borderRadius: radius,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.black38,
          child: Container(
            height: size,
            width: size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  AppImages.heart,
                  width: 16,
                  color: Colors.red[400],
                ),
                Text(
                  '70',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
