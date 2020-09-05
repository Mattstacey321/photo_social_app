import 'package:get/get.dart';

class SavedPostController extends GetxController {
  List<String> users = <String>["asd", "bas", "Asd"];
  var _selectedValue = "asd".obs;
  String get selectedValue => _selectedValue.value;

  void setValue(String value) {
    _selectedValue.value = value;
  }
}
