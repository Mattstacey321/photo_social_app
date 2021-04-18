import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeUtils {
  String getCurrentTime({@required String time, String locale = 'en'}) {
    var yourTime = DateTime.parse(time);
    var now = DateTime.now();
    var difference = now.difference(yourTime);
    return timeago.format(now.subtract(difference), locale: locale);
  }
}
