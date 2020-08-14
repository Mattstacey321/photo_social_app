import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {
  static SharedPreferences prefs;
  static GraphQLClient _client(String token) => GraphQL().mainClient(token);

  static Future<List<PostModel>> getForumPost({String forumId, int page, int limit}) async {
    prefs = await SharedPreferences.getInstance();
    await _client(prefs.getString("token")).getForumPost(forumId: forumId, page: page, limit: limit);
  }
}
