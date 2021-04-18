import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/app_interface.dart';
import '../models/base_result_model.dart';
import '../models/comment_model.dart';

class CommentRepository implements ICommentRepository {
  final _gplSchema = GqlSchema();
  final GraphQLClient _client;
  CommentRepository({@required GraphQLClient client}) : _client = client;

  @override
  Future<List<CommentModel>> getPostComment({
    @required String postId,
    @required int page,
    int limit = 10,
  }) async {
    final schemaName = _gplSchema.getPostComment.name;
    final result = await _client.getPostComment(postId: postId, page: page, limit: limit);
    return CommentsModel.fromList(result.data[schemaName]).comments;
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
