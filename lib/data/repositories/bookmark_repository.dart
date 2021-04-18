import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/app_interface.dart';
import '../models/base_result_model.dart';

class BookmarkRepository implements IBookmarkRepository {
  final _gqlSchema = GqlSchema();
  final GraphQLClient _client;
  BookmarkRepository({@required GraphQLClient client}) : _client = client;

  @override
  Future<BaseResultModel> bookmarkPost({String postId, String collectionName}) async {
    final schemaName = _gqlSchema.bookmarkPost.name;
    final result = await _client.bookmarkPost(postId: postId, collectionName: collectionName);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> bookmarkToExistingCollection(
      {String postId, List<String> collectionIds}) async {
    final schemaName = _gqlSchema.boomarkToExistingCollection.name;
    var result =
        await _client.bookmarkExistingCollection(postId: postId, collectionIds: collectionIds);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> unBookmarkPost({List<String> postIds, String collectionId}) async {
    final schemaName = _gqlSchema.removeCollectionItem.name;
    var result = await _client.removeCollectionItem(postIds: postIds, collectionId: collectionId);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> unBookmarkExistingCollection(
      {String postId, List<String> collectionIds}) async {
    final schemaName = _gqlSchema.removeMultipleItemFromCollection.name;
    var result = await _client.removePostFromMultipleCollection(
        postId: postId, collectionIds: collectionIds);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }
}
