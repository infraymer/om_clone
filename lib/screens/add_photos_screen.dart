import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class AddPhotosScreen extends StatelessWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const AddPhotosScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.photosTitle,
          ),
          SizedBox(height: 10),
          Expanded(child: _buildList()),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: Dimens.horizontalMarginButtonRegScreen,
            ),
            child: AppRoundFilledButton(
              onPressed: onActionClicked,
              text: Strings.done,
            ),
          ),
          SizedBox(height: Dimens.bottomMarginButtonRegScreen),
        ],
      ),
    );
  }

  List<Widget> _buildSelectPhotoList() {
    return List.generate(9, (index) => SelectPhoto());
  }

  Widget _buildList() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: ReorderableWrap(
        spacing: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        runSpacing: 20,
        maxMainAxisCount: 3,
        minMainAxisCount: 3,
        children: _buildSelectPhotoList(),
        onReorder: _onReorder,
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {}
}

class SelectPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth > 100
            ? constraints.maxWidth / 3 * 0.7
            : constraints.maxWidth,
        height: constraints.maxWidth > 100
            ? constraints.maxWidth / 3 * 0.7
            : constraints.maxWidth,
        child: Stack(
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
        ),
      );
    });
  }
}

Widget _buildOldPhotosList() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: LayoutGrid(
        templateColumnSizes: List.generate(3, (index) => FlexibleTrackSize(1)),
        templateRowSizes: List.generate(3, (index) => FlexibleTrackSize(1)),
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
  );
}
