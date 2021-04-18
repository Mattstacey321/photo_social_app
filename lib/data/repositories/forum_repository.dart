import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/app_interface.dart';
import '../models/forum_model.dart';
import '../models/hash_tag_model.dart';

class ForumRepository implements IForumRepository {
  final _gplSchema = GqlSchema();
  final GraphQLClient _client;
  ForumRepository({@required GraphQLClient client}) : _client = client;

  @override
  Future<List<HashTagModel>> getHashTagStats() async {
    final schemaName = _gplSchema.getHashTagStats.name;
    final result = await _client.getHashTagStats();
    return HashTagModels.fromList(result.data[schemaName]).hashtags;
  }

  @override
  Future<List<ForumModel>> getForum({@required int page, int limit = 10}) async {
    final result = await _client.getForums(
      page: page,
      limit: limit,
    );
    final schemaName = _gplSchema.getForums.name;
    return Forums.fromList(result.data[schemaName]).forums;
  }
}
