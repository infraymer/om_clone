import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/utils/share_util.dart';
import 'package:tinder/view_model/selection_controller.dart';
import 'package:tinder/widgets/circle_status.dart';
import 'package:tinder/widgets/no_button.dart';
import 'package:tinder/widgets/screen_container.dart';
import 'package:tinder/widgets/yes_button.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({Key key, this.user}) : super(key: key);

  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => user,
      child: ScreenContainer(
        child: Container(
          width: double.infinity,
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 500,
                    child: Stack(
                      children: <Widget>[
                        PageView.builder(
                          controller: controller,
                          itemCount: user.imgs.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: user.heroTag,
                              child: Image.network(
                                user.imgs.elementAtOrNull(index) ?? '',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: PageIndicators(
                            controller: controller,
                            count: user.imgs.length,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (user.isLike)
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
                                        child: SvgPicture.asset(
                                          AppImages.heart,
                                          height: 18.0,
                                          width: 18.0,
                                          allowDrawingOutsideViewBox: true,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'They like you!',
                                          style: TextStyle(
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.black54,
                                                  blurRadius: 4,
                                                  spreadRadius: 4,
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 500),
                    child: _Content(data: user),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 20, top: 470),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_downward),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final User data;

  const _Content({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          _Name(
            text: '${data.name}, ${data.age}',
            isActive: data.isOnline,
          ),
//          if (data.aboutMe?.isNotEmpty == true) SizedBox(height: 8),
//          if (data.aboutMe?.isNotEmpty == true)
//            _IconTextItem(
//              icon: Icons.home,
//              text: data.aboutMe,
//            ),
          SizedBox(height: 8),
          _IconTextItem(
            icon: Icons.place,
            text: '1 kilometer away',
          ),
          SizedBox(height: 20),
          _Description(data.aboutMe),
          SizedBox(height: 30),
          _ShareProfile(data.name),
          SizedBox(height: 20),
          _Report(data.name),
          SizedBox(height: 20),
          _Buttons(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Name extends StatelessWidget {
  final String text;
  final bool isActive;

  const _Name({Key key, this.text, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          CircleStatus(isActive: isActive),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String text;

  const _Description(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        text ?? '',
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class _IconTextItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconTextItem({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            text ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareProfile extends StatelessWidget {
  final String name;

  const _ShareProfile(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ShareUtil.shareOneMatch();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Share $name'.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            'See what a friend thinks'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _Report extends StatelessWidget {
  final String name;
  const _Report(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text('Report $name'.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            )),
        onPressed: () {},
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NoButton(
          onTap: () {
            SelectionController.to?.dislike();
            Get.back();
          },
        ),
        SizedBox(width: 20),
        YesButton(
          onTap: () {
            SelectionController.to?.like();
            Get.back();
          },
        ),
      ],
    );
  }
}

class PageIndicators extends StatefulWidget {
  final PageController controller;
  final int count;

  PageIndicators({this.controller, this.count});

  @override
  _PageIndicatorsState createState() => _PageIndicatorsState();
}

class _PageIndicatorsState extends State<PageIndicators> {
  int _current = 0;
  double _lastPage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final page = widget.controller.page;
      _current = page > _lastPage ? page.ceil() : page.toInt();
      setState(() {});
      _lastPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          widget.count,
          (index) => Expanded(
                child: Indicator(
                  isSelected: index == _current,
                ),
              )),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isSelected;

  const Indicator({Key key, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? Colors.white : Colors.white24,
      ),
    );
  }
}
