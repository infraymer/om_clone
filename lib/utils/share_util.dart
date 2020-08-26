import 'dart:io';

import 'package:share/share.dart';

class ShareUtil {

  static void shareOneMatch() {
    if (Platform.isAndroid)
      Share.share('https://play.google.com/store/apps/details?id=com.onematch.client');
    else if (Platform.isIOS)
      Share.share('https://apps.apple.com/us/app/id1522263926');
  }
}