import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_downloader/flutter_downloader.dart';

class GlobalConfig {
  static Future setLocate() async {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
  }

  static Future initializeDownloader() async {
    await FlutterDownloader.initialize(debug: true);
  }
}
