import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/models/hash_tag_model.dart';
import 'package:photo_social/api/extension/index.dart';
import 'package:photo_social/models/post_model.dart';

class HashTagRepository {
  GraphQLClient _client = Get.find<GraphQL>().selectClient;

  Future<List<HashTagModel>> getHashTag() async {
    final result = await _client.getHashTagStats();
    final schemaName = GqlSchema.getHashTagStats.name;
    return HashTagModels.fromList(result.data[schemaName]).hashtags;
  }

  Future<List<PostModel>> getPostByHashTag(
      {String hashTag, int page, int limit = 10}) async {
    final result = await _client.getPostByHashTag(
        hashTag: hashTag, page: page, limit: limit);
    final schemaName = GqlSchema.getPostByHashtag.name;
    return PostsModel.fromList(result.data[schemaName]).posts;
  }
}
