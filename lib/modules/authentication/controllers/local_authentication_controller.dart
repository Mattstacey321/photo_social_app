import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/interface/app_interface.dart';
import '../../../data/models/user_model.dart';

class LocalAuthentication implements IGraphpl {
  static const SET_SESSION_KEY = "user";
  final GetStorage _storage = Get.find<GetStorage>();

  Future<bool> hasSession() async => await _storage.hasData("user");

  Future initTheme() async => await _storage.write("darkMode", false);

  Future<void> initSession() async {
    if (await hasSession()) {
    } else
      await initTheme();
  }

  Future<void> setSession(UserModel credentials) async {
    await _storage.write(
      SET_SESSION_KEY,
      jsonEncode(
        credentials.toJson(),
      ),
    );
  }

  void clearSession() {
    _storage.remove(SET_SESSION_KEY);
  }

  @override
  Future<String> getToken() async {
    final String data = await _storage.read(SET_SESSION_KEY);

    if (data != null) {
      final UserModel userInfo = UserModel.fromJson(jsonDecode(data));
      return userInfo.token;
    }
    return null;
  }

  @override
  Future<UserModel> getUserInfo() async {
    final String data = await _storage.read(SET_SESSION_KEY);

    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    }
    return UserModel.guest();
  }
}
