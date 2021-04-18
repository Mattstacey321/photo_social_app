import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/app_interface.dart';
import '../models/base_result_model.dart';
import '../models/post_model.dart';

class PostRepository implements IPostRepository {
  final _gplSchema = GqlSchema();
  final GraphQLClient _client;
  PostRepository({@required GraphQLClient client}) : _client = client;

  @override
  Future<List<PostModel>> getForumPost({
    @required String forumId,
    @required int page,
    int limit = 10,
  }) async {
    final schemaName = _gplSchema.getForumPost.name;
    final result = await _client.getForumPost(forumId: forumId, page: page, limit: limit);
    return PostsModel.fromList(result.data[schemaName]).posts;
  }

  @override
  Future<List<PostModel>> getPostByHashTag({
    @required String hashTag,
    @required int page,
    int limit = 10,
  }) async {
    final schemaName = _gplSchema.getPostByHashtag.name;
    final result = await _client.getPostByHashTag(hashTag: hashTag, limit: limit, page: page);
    return PostsModel.fromList(result.data[schemaName]).posts;
  }

  @override
  Future<BaseResultModel> reactionPost({
    @required String postId,
    @required String forumId,
    String type = r'heart',
  }) async {
    final schemaName = _gplSchema.reactionPost.name;
    final result = await _client.reactionPost(postId: postId, forumId: forumId, type: type);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }
}
