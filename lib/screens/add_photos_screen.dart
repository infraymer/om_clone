import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/utils/view_utils.dart';
import 'package:tinder/view_model/registration_view_model.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/screen_container.dart';

class AddPhotosScreen extends StatefulWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const AddPhotosScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

  @override
  _AddPhotosScreenState createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _isLoading = ValueNotifier<bool>(false);


  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegistrationViewModel>(context);
    return ScreenContainer(
      keyScaffold: _scaffoldKey,
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: widget.onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.photosTitle,
          ),
          SizedBox(height: 10),
          Expanded(child: PhotoBlock()),
          SizedBox(height: 30),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: Dimens.horizontalMarginButtonRegScreen,
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, value, child) {
                  if (value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return AppRoundFilledButton(
                    onPressed: () {
                      _isLoading.value = true;
                      model
                          .onDoneClicked()
                          .then((value) => widget.onActionClicked())
                          .catchError((e) => showMessage(_scaffoldKey, 'Upload error'))
                          .whenComplete(() => _isLoading.value = false);
                    },
                    text: Strings.done,
                  );
                },
              )),
          SizedBox(height: Dimens.bottomMarginButtonRegScreen),
        ],
      ),
    );
  }
}

class PhotoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegistrationViewModel>(context);
//    final model = context.watch<RegistrationViewModel>();
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: ReorderableWrap(
        spacing: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        runSpacing: 20,
        maxMainAxisCount: 3,
        minMainAxisCount: 3,
        children: _buildSelectPhotoList(context),
        onReorder: (int oldIndex, int newIndex) {
          model.swapImage(oldIndex, newIndex);
        },
      ),
    );
  }

  List<Widget> _buildSelectPhotoList(BuildContext context) {
    // final model = context.watch<RegistrationViewModel>();
    final model = Provider.of<RegistrationViewModel>(context, listen: false);
    final list = <Widget>[];
    model.photos.asMap().forEach(
          (i, e) => list.add(
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                final file = File(pickedFile.path);
                model.setImage(i, file);
              },
              child: SelectPhoto(
                file: e,
                index: i,
              ),
            ),
          ),
        );
    return list;
  }
}

class SelectPhoto extends StatelessWidget {
  final File file;
  final int index;

  const SelectPhoto({Key key, this.file, this.index}) : super(key: key);

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
                  color: file == null ? AppColors.selectPhotoBg : null,
                ),
                child: Center(
                  child: file != null
                      ? Image.file(
                          file,
                          fit: BoxFit.fill,
                        )
                      : null,
                )),
            if (file == null)
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
