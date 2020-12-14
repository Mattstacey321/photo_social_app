import 'package:photo_social/models/base_result_model.dart';
import 'package:photo_social/models/post_model.dart';

abstract class IPostRepository {
  Future<List<PostModel>> getForumPost({
    String forumId,
    int page,
    int limit = 10,
  });
  Future<List<PostModel>> getPostByHashTag({
    String hashTag,
    int page,
    int limit = 10,
  });
  Future<BaseResultModel> reactionPost({
    String postId,
    String forumId,
    String type = "heart",
  });
}
