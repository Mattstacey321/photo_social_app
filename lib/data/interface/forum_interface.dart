import '../models/forum_model.dart';
import '../models/hash_tag_model.dart';

abstract class IForumRepository {
  Future<List<ForumModel>> getForum({int page, int limit = 10});
  Future<List<HashTagModel>> getHashTagStats();
}
