import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/interface/collection_interface.dart';
import 'package:photo_social/models/base_result_model.dart';
import 'package:photo_social/models/collection_model.dart';
import 'package:photo_social/api/extension/index.dart';
import 'package:photo_social/models/post_model.dart';

class CollectionRepository implements ICollection {
  GraphQLClient _client = Get.find<GraphQL>().selectClient;
  @override
  Future<List<BookmarkCollectionModel>> getBookmarkCollection(
      {int page, int limit = 10}) async {
    String schemaName = GqlSchema.getUserBookmark.name;
    var result = await _client.getUserBookmark(page: page, limit: 10);
    return BookmarkCollectionsModel.fromList(result.data[schemaName])
        .collections;
  }

  @override
  Future<List<PostModel>> getCollectionDetail(
      {String collectionId, int page, int limit}) async {
    {
      var result = await _client.getPostByCollection(
          collectionId: collectionId, page: page);
      return PostsModel.fromList(
              result.data[GqlSchema.getPostByCollection.name])
          .posts;
    }
  }

  @override
  Future<BaseResultModel> removeCollectionItem(
      {List<String> postIds, String collectionId}) async {
    final String schemaName = GqlSchema.removeCollectionItem.name;
    var result = await _client.removeCollectionItem(
        postIds: postIds, collectionId: collectionId);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<BaseResultModel> removeMultipleCollection(
      {List<String> collectionIds}) async {
    var result = await _client.removeCollections(collectionIds: collectionIds);
    return BaseResultModel.fromJson(
        result.data[GqlSchema.removeCollections.name]);
  }
}
