import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseRepository {
  static String _token = Get.find<SharedPreferences>().getString('token') ?? "";
  static bool _loginAsGuest = Get.find<SharedPreferences>().getBool('isSkipLogin') ?? false;

  static GraphQLClient get _client => GraphQL().mainClient(_token);
  static GraphQLClient get _guestClient => GraphQL().guestClient();
  static GraphQLClient get pubClient => GraphQL().pubClient();

  static GraphQLClient get selectClient {
    if (_loginAsGuest == null) {
      return _guestClient;
    } else
      return _client;
  }
}
