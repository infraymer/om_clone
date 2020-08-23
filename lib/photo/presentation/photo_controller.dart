import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:get/get.dart';
import 'package:tinder/photo/model/app_photo.dart';
import 'package:tinder/remote/file_remote_data_source.dart';

class PhotoController extends GetxController {
  static PhotoController get to => Get.find();
  final _fileRemoteDataSource = FileRemoteDataSource();
  final RxList<AppPhoto> photos = List.generate(9, (index) => AppPhoto()).obs;
  final isLoading = false.obs;

  PhotoController([List<AppPhoto> initPhotos = const []]) {
    photos.value = List.generate(
        9, (index) => initPhotos.elementAtOrNull(index) ?? AppPhoto());
    print('object');
  }

  void setImage(int index, File file) {
    photos[index] = AppPhoto(file: file);
  }

  void swapImage(int oldIndex, int newIndex) {
    final e = photos[oldIndex];
    photos.removeAt(oldIndex);
    photos.insert(newIndex, e);
  }

  Future<void> upload() async {
    try {
      isLoading.value = true;
      await uploadImages();
      Get.back(result: photos.value.where((e) => !e.isEmpty).toList());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<String>> uploadImages() async {
    final images = photos.where((element) => element?.file != null).toList();
    final map = images.map((e) async {
      final url = await _fileRemoteDataSource.uploadImage(e.file);
      photos[photos.value.indexOf(e)] = e.copyWith(url: url);
    });
    final urls = await Future.wait(map);
    return urls;
  }
}
