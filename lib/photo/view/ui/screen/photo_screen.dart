import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tinder/photo/model/app_photo.dart';
import 'package:tinder/photo/presentation/photo_controller.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/utils/dialogs.dart';
import 'package:tinder/widgets/app_photo.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';

class PhotoScreen extends StatelessWidget {
  final List<AppPhoto> initPhotos;

  const PhotoScreen({Key key, this.initPhotos = const <AppPhoto>[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoController>(
      init: PhotoController(initPhotos),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Photos'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(child: PhotoBlock()),
              SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : AppRoundFilledButton(
                        text: 'Save',
                        onPressed: () => controller.upload(),
                      ),
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}

class PhotoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: ReorderableWrap(
          spacing: 20,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          runSpacing: 20,
          maxMainAxisCount: 3,
          minMainAxisCount: 3,
          children:
              _buildSelectPhotoList(context, PhotoController.to.photos.value),
          onReorder: (int oldIndex, int newIndex) {
            PhotoController.to.swapImage(oldIndex, newIndex);
          },
        ),
      ),
    );
  }

  List<Widget> _buildSelectPhotoList(
      BuildContext context, List<AppPhoto> imgs) {
    // final model = context.watch<RegistrationViewModel>();
    final list = <Widget>[];
    imgs.asMap().forEach(
          (i, e) => list.add(
            GestureDetector(
              onTap: () async {
                if (e.isEmpty) {
                  onSelectPhoto(i);
                } else {
                  onRemovePhoto(i);
                }
              },
              child: SelectPhoto(
                photo: e,
                index: i,
              ),
            ),
          ),
        );
    return list;
  }

  void onSelectPhoto(int index) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    PhotoController.to.setImage(index, file);
  }

  void onRemovePhoto(int index) async {
    PhotoController.to.setImage(index, null);
  }
}

class SelectPhoto extends StatelessWidget {
  final AppPhoto photo;
  final int index;

  const SelectPhoto({Key key, this.index, this.photo}) : super(key: key);

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
                color: photo == null ? AppColors.selectPhotoBg : Colors.black12,
              ),
              child: Center(
                child: AppImageWidget(image: photo),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                transform: Matrix4.translationValues(12.0, 12.0, 0.0),
                child: Icon(photo?.isEmpty == true ? Icons.add_circle : Icons.remove_circle, size: 24),
              ),
            ),
          ],
        ),
      );
    });
  }
}
