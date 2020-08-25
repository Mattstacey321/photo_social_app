import 'package:flutter/material.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/base_repository.dart';

class ForumRepository {
  static Future<int> countForumPost({@required String forumId}) async {
    var result = await BaseRepository.selectClient.countForumPost(forumId: forumId);
    return result.data['countForumPost'];
  }

  static Future<List<ForumModel>> getForums({int page = 1, int limit = 10}) async {
    var result = await BaseRepository.selectClient.getForums(page: page, limit: limit);
    return Forums.fromList(result.data['getForums']).forums;
  }
}
