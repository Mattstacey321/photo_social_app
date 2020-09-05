import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/utils/check_token.dart';

class RequestFeatureController extends GetxController {
  var requestTextContl = TextEditingController().obs;
  var hasValue = false.obs;
  var isAuthentication = false.obs;
  TextEditingController get requestContrl => requestTextContl.value;

  @override
  void onInit() {
    checkUser();
  }

  void checkUser() async {
    isAuthentication.value = await isAuth();
  }

  void onChange(String value) {
    hasValue.value = value == "" ? true : false;
  }

  void submit() async {
    Future.delayed(Duration(seconds: 3),
        () => BotToast.showLoading(allowClick: true, clickClose: true));
  }
}
