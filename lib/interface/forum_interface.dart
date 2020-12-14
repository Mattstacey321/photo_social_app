import 'package:photo_social/models/forum_model.dart';
import 'package:photo_social/models/hash_tag_model.dart';

abstract class IForumRepository {
  Future<List<ForumModel>> getForum({int page, int limit = 10});
  Future<List<HashTagModel>> getHashTagStats();
}
