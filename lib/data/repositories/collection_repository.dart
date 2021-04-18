import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/collection_interface.dart';
import '../models/base_result_model.dart';
import '../models/collection_model.dart';
import '../models/post_model.dart';

class CollectionRepository implements ICollection {
  final _gqlSchema = GqlSchema();
  final GraphQLClient _client;
  CollectionRepository({@required GraphQLClient client}) : _client = client;

  @override
  Future<List<BookmarkCollectionModel>> getBookmarkCollection({int page, int limit = 10}) async {
    final schemaName = _gqlSchema.getUserBookmark.name;
    final result = await _client.getUserBookmark(page: page, limit: 10);
    return BookmarkCollectionsModel.fromList(result.data[schemaName]).collections;
  }

  @override
  Future<List<PostModel>> getCollectionDetail({String collectionId, int page, int limit}) async {
    final schemaName = _gqlSchema.getPostByCollection.name;
    final result = await _client.getPostByCollection(collectionId: collectionId, page: page);
    return PostsModel.fromList(result.data[schemaName]).posts;
  }

  @override
  Future<BaseResultModel> removeCollectionItem({List<String> postIds, String collectionId}) async {
    final schemaName = _gqlSchema.removeCollectionItem.name;
    final result = await _client.removeCollectionItem(postIds: postIds, collectionId: collectionId);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> removeMultipleCollection({List<String> collectionIds}) async {
    final schemaName = _gqlSchema.removeCollections.name;
    final result = await _client.removeCollections(collectionIds: collectionIds);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }
}
