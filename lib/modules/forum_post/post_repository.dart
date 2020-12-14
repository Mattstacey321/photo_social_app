import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/interface/app_interface.dart';
import 'package:photo_social/models/base_result_model.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/api/extension/index.dart';

class PostRepository implements IPostRepository {
  GraphQLClient _client = Get.find<GraphQL>().selectClient;

  Future<List<PostModel>> getForumPost({
    @required String forumId,
    @required int page,
    int limit = 10,
  }) async {
    final schemaName = GqlSchema.getForumPost.name;
    final result =
        await _client.getForumPost(forumId: forumId, page: page, limit: limit);
    return PostsModel.fromList(result.data[schemaName]).posts;
  }

  Future<List<PostModel>> getPostByHashTag({
    @required String hashTag,
    @required int page,
    int limit = 10,
  }) async {
    final schemaName = GqlSchema.getPostByHashtag.name;
    final result = await _client.getPostByHashTag(
        hashTag: hashTag, limit: limit, page: page);
    return PostsModel.fromList(result.data[schemaName]).posts;
  }

  Future<BaseResultModel> reactionPost({
    @required String postId,
    @required String forumId,
    String type = "heart",
  }) async {
    final schemaName = GqlSchema.reactionPost.name;
    final result = await _client.reactionPost(
        postId: postId, forumId: forumId, type: type);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }
}
