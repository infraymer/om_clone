import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/about_screen.dart';
import 'package:tinder/screens/add_photos_screen.dart';
import 'package:tinder/screens/birthday_screen.dart';
import 'package:tinder/screens/gender_screen.dart';
import 'package:tinder/screens/name_screen.dart';
import 'package:tinder/widgets/screen_container.dart';

class RegistrationScreen extends StatelessWidget {

  final PageController controller = PageController();

  get currentPage => controller.page.toInt();

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 50),
            child: ProgressBar(controller: controller, max: 6,),
          ),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: <Widget>[
                NameScreen(
                  onBackClicked: () => Navigator.pop(context),
                  onActionClicked: _nextPage,
                ),
                BirthdayScreen(
                  onBackClicked: _prevPage,
                  onActionClicked: _nextPage,
                ),
                GenderScreen(
                  onBackClicked: _prevPage,
                  onActionClicked: _nextPage,
                ),
                AboutScreen(
                  onBackClicked: _prevPage,
                  onActionClicked: _nextPage,
                ),
                AddPhotosScreen(
                  onBackClicked: _prevPage,
                  onActionClicked: () => Navigator.pushReplacement(context, WelcomeRoute()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _nextPage() {
    controller.animateToPage(
      currentPage + 1, duration: Duration(milliseconds: 300),
      curve: Curves.linearToEaseOut,);
  }

  void _prevPage() {
    controller.animateToPage(
      currentPage - 1, duration: Duration(milliseconds: 300),
      curve: Curves.linearToEaseOut,);
  }
}

class ProgressBar extends StatefulWidget {
  final int max;
  final PageController controller;

  const ProgressBar({Key key, this.max = 0, this.controller}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  var index = 0;

  get page => widget.controller.page.toInt();

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      if (page % 1 != 0) return
        print(widget.controller.page.toInt());
      index = widget.controller.page.toInt();
      setState(() {});
    });
    final height = 8.0;
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          width: double.infinity,
          color: AppColors.textField,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          color: AppColors.main,
          height: height,
          width: MediaQuery
              .of(context)
              .size
              .width * (index + 1) / widget.max,
        ),
      ],
    );
  }
}
