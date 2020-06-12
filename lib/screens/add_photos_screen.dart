import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class AddPhotosScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const AddPhotosScreen({Key key, this.onActionClicked, this.onBackClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.photosTitle,
            centerTitle: true,
          ),
          SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: LayoutGrid(
                templateColumnSizes:
                    List.generate(3, (index) => FlexibleTrackSize(1)),
                templateRowSizes:
                    List.generate(3, (index) => FlexibleTrackSize(1)),
                rowGap: 20,
                columnGap: 20,
                children: <Widget>[
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                  SelectPhoto(),
                ],
              ),
            ),
          ),
          SizedBox(height: 60),
          Text(
            Strings.photosDescription,
            style: TextStyles.photoDescription,
          ),
          SizedBox(height: 30),
          // Text(Strings.birthdayDescription, style: TextStyles.fieldDescription),
        ],
      ),
    );
  }
}

class SelectPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.selectPhotoBg,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            transform: Matrix4.translationValues(12.0, 12.0, 0.0),
            child: Icon(Icons.add_circle, size: 24),
          ),
        )
      ],
    );
  }
}
