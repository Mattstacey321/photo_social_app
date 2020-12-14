import 'en-US/en_us_translations.dart';
import 'vi-VN/vi_vn_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en_US': enUs,
    'vi_VN': viVN
  };
}
