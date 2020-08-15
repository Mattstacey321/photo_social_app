import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumRepository {
  static SharedPreferences prefs;
  static GraphQLClient _client(String token) => GraphQL().mainClient(token);

  static Future countForumPost() async {
    String token = Get.find<SharedPreferences>().getString('token');
    return await _client(token).countForumPost();
  }

  static Future getForums({int page = 1, int limit = 10}) async {
    String token = Get.find<SharedPreferences>().getString('token');
    var result = await _client(token).getForums(page: page, limit: limit);
    return Forums.fromList(result.data);
  }
}
