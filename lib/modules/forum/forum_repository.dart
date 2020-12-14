import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/extension/index.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/interface/app_interface.dart';
import 'package:photo_social/models/forum_model.dart';
import 'package:photo_social/models/hash_tag_model.dart';

class ForumRepository implements IForumRepository {
  GraphQLClient _client = Get.find<GraphQL>().selectClient;

  @override
  Future<List<HashTagModel>> getHashTagStats() async {
    final result = await _client.getHashTagStats();
    final schemaName = GqlSchema.getHashTagStats.name;
    return HashTagModels.fromList(result.data[schemaName]).hashtags;
  }

  @override
  Future<List<ForumModel>> getForum(
      {@required int page, int limit = 10}) async {
    final result = await _client.getForums(
      page: page,
      limit: limit,
    );
    final schemaName = GqlSchema.getForums.name;
    return Forums.fromList(result.data[schemaName]).forums;
  }
}
