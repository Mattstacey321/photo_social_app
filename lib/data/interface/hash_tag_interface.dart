import '../models/hash_tag_model.dart';
import '../models/post_model.dart';

abstract class IHashTagRepository {
  Future<List<HashTagModel>> getHashTag();
  Future<List<PostModel>> getPostByHashTag();
}
