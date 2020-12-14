import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/extension/index.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/interface/app_interface.dart';
import 'package:photo_social/models/base_result_model.dart';

class BookmarkRepository implements IBookmarkRepository {
  GraphQLClient _client = Get.find<GraphQL>().selectClient;

  @override
  Future<BaseResultModel> bookmarkPost(
      {String postId, String collectionName}) async {
    var result = await _client.bookmarkPost(
        postId: postId, collectionName: collectionName);
    return BaseResultModel.fromJson(result.data[GqlSchema.bookmarkPost.name]);
  }

  @override
  Future<BaseResultModel> bookmarkToExistingCollection(
      {String postId, List<String> collectionIds}) async {
    final String schemaName = GqlSchema.boomarkToExistingCollection.name;
    var result = await _client.bookmarkExistingCollection(
        postId: postId, collectionIds: collectionIds);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> unBookmarkPost(
      {List<String> postIds, String collectionId}) async {
    final String schemaName = GqlSchema.removeCollectionItem.name;
    var result = await _client.removeCollectionItem(
        postIds: postIds, collectionId: collectionId);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> unBookmarkExistingCollection(
      {String postId, List<String> collectionIds}) async {
    final String schemaName = GqlSchema.removeMultipleItemFromCollection.name;
    var result = await _client.removePostFromMultipleCollection(
        postId: postId, collectionIds: collectionIds);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }
}
