import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share/share.dart';

class ShareUtil {
  static void shareOneMatch() async {
    final ByteData bytes = await rootBundle.load('assets/images/logo.png');
    final Uint8List list = bytes.buffer.asUint8List();

    Directory dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final file = await File('${dir.path}/logo.png').create();
    file.writeAsBytesSync(list);

    String link = (Platform.isAndroid)
        ? 'https://play.google.com/store/apps/details?id=com.onematch.client'
        : 'https://apps.apple.com/us/app/id1522263926';

    Share.shareFiles(<String>[file.path],
        text:
            'Check out OneMatch... it shows you who likes you nearby!\n$link');
  }
}
