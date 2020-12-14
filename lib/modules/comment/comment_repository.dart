import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/interface/app_interface.dart';
import 'package:photo_social/models/base_result_model.dart';
import 'package:photo_social/models/comment_model.dart';
import 'package:photo_social/api/extension/index.dart';

class CommentRepository implements ICommentRepository {
  GraphQLClient _client = Get.find<GraphQL>().selectClient;

  @override
  Future<List<CommentModel>> getPostComment({
    @required String postId,
    @required int page,
    int limit = 10,
  }) async {
    var result =
        await _client.getPostComment(postId: postId, page: page, limit: limit);
    return CommentsModel.fromList(result.data[GqlSchema.getPostComment.name])
        .comments;
  }

  @override
  Future<BaseResultModel> editComment({String commentId, String newComment}) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResultModel> removeComment({String commentId}) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResultModel> addComment({String comment}) {
    throw UnimplementedError();
  }
}
