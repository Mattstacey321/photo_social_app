import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? "";
  bool isSkipLogin = prefs.getBool("isSkipLogin") ?? false;
  return (token == "" && isSkipLogin == false);
}