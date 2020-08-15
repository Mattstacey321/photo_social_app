import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {
  static String token = Get.find<SharedPreferences>().getString('token');
  static bool loginAsGuest = Get.find<SharedPreferences>().getBool('isSkipLogin');

  static GraphQLClient get _client => GraphQL().mainClient(token);
  static GraphQLClient get _guestClient => GraphQL().guestClient();

  static Future<List<PostModel>> getForumPost({String forumId, int page, int limit}) async {
    var result = loginAsGuest
        ? await _guestClient.getForumPost(forumId: forumId, page: page, limit: limit)
        : await _client.getForumPost(forumId: forumId, page: page, limit: limit);
    return PostsModel.fromList(result.data['getForumPost']).posts;
  }
}
