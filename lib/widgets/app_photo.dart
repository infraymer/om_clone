import 'package:flutter/material.dart';
import 'package:tinder/photo/model/app_photo.dart';

class AppImageWidget extends StatelessWidget {
  final AppPhoto image;

  const AppImageWidget({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image?.url != null
        ? Image.network(
            image?.url,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )
        : image?.file != null
            ? Image.file(
                image?.file,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )
            : Container(color: Colors.grey);
  }
}
