import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumRepository {
  static SharedPreferences prefs;
  static GraphQLClient _client(String token) => GraphQL().mainClient(token);

  static Future countForumPost() async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return await _client(token).countForumPost();
  }
}
