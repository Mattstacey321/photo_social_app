import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:photo_social/interface/app_interface.dart';
import 'package:photo_social/models/user_model.dart';

class LocalAuthentication implements IGraphpl {
  static const SET_SESSION_KEY = "user";
  final FlutterSecureStorage _storage = Get.find<FlutterSecureStorage>();

  Future<bool> checkSession() async => await _storage.containsKey(key: "user");

  Future initTheme() async =>
      await _storage.write(key: "darkMode", value: "false");

  Future<void> initSession() async {
    if (await checkSession()) {
    } else
      await initTheme();
  }

  Future<void> setSession(UserModel credentials) async {
    await _storage.write(
        key: SET_SESSION_KEY, value: jsonEncode(credentials.toJson()));
  }

  void clearSession() {
    _storage.delete(key: SET_SESSION_KEY);
  }

  @override
  Future<String> getToken() async {
    final String data = await _storage.read(key: SET_SESSION_KEY);

    if (data != null) {
      final UserModel userInfo = UserModel.fromJson(jsonDecode(data));
      return userInfo.token;
    }
    return null;
  }

  @override
  Future<UserModel> getUserInfo() async {
    final String data = await _storage.read(key: SET_SESSION_KEY);

    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    }
    return UserModel.guest();
  }
}
