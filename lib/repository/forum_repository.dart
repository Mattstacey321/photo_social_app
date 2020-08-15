import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumRepository {
  static bool loginAsGuest = Get.find<SharedPreferences>().getBool('isSkipLogin');
  static GraphQLClient _client(String token) => GraphQL().mainClient(token);
  static GraphQLClient get _guestClient => GraphQL().guestClient();

  static Future<int> countForumPost({String forumId}) async {
    String token = Get.find<SharedPreferences>().getString('token');
   
    if(loginAsGuest){
       var result = await _guestClient.countForumPost(forumId: forumId);
       return result.data['countForumPost'];
    }else {
       var result = await _client(token).countForumPost(forumId: forumId);
       return result.data['countForumPost'];
    } 
  }

  static Future<List<ForumModel>> getForums({int page = 1, int limit = 10}) async {
    String token = Get.find<SharedPreferences>().getString('token');
    bool loginAsGuest = Get.find<SharedPreferences>().getBool('isSkipLogin');
    if (loginAsGuest) {
      var result = await _guestClient.getForums(page: page, limit: limit);
      return Forums.fromList(result.data['getForums']).forums;
    } else {
      var result = await _client(token).getForums(page: page, limit: limit);
      return Forums.fromList(result.data).forums;
    }
  }
}
