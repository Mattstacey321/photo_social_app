import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/hash_tag_interface.dart';
import '../models/hash_tag_model.dart';
import '../models/post_model.dart';

class HashTagRepository implements IHashTagRepository {
  final _gplSchema = GqlSchema();
  final GraphQLClient _client;
  HashTagRepository({@required GraphQLClient client}) : _client = client;

  @override
  Future<List<HashTagModel>> getHashTag() async {
    final result = await _client.getHashTagStats();
    final schemaName = _gplSchema.getHashTagStats.name;
    return HashTagModels.fromList(result.data[schemaName]).hashtags;
  }

  @override
  Future<List<PostModel>> getPostByHashTag({String hashTag, int page, int limit = 10}) async {
    final result = await _client.getPostByHashTag(hashTag: hashTag, page: page, limit: limit);
    final schemaName = _gplSchema.getPostByHashtag.name;
    return PostsModel.fromList(result.data[schemaName]).posts;
  }
}
