import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/models/photoModel.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  Rx<PhotoModel> data = Rx<PhotoModel>();
  var mockData = [AppConstraint.urlDemo1, AppConstraint.urlDemo2, AppConstraint.urlDemo3];

  int get countMockData => mockData.length;
}
