import 'package:photo_social/models/base_result_model.dart';
import 'package:photo_social/models/collection_model.dart';
import 'package:photo_social/models/post_model.dart';

abstract class ICollection {
  Future<BaseResultModel> removeCollectionItem();
  Future<List<BookmarkCollectionModel>> getBookmarkCollection();
  Future<List<PostModel>> getCollectionDetail();
  Future<BaseResultModel> removeMultipleCollection();
}
