
import 'dart:io';

class AppPhoto {
  final File file;
  final String url;

  bool get isEmpty => file == null && url == null;

  AppPhoto({this.file, this.url});

  AppPhoto copyWith({
    File file,
    String url,
  }) {
    return new AppPhoto(
      file: file ?? this.file,
      url: url ?? this.url,
    );
  }
}