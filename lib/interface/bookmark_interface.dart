import 'package:photo_social/models/base_result_model.dart';

abstract class IBookmarkRepository {
  Future<BaseResultModel> bookmarkPost({String postId, String collectionName});

  Future<BaseResultModel> unBookmarkPost(
      {List<String> postIds, String collectionId});

  Future<BaseResultModel> bookmarkToExistingCollection(
      {String postId, List<String> collectionIds});

  Future<BaseResultModel> unBookmarkExistingCollection(
      {String postId, List<String> collectionIds});
}
