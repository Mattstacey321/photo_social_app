import '../models/base_result_model.dart';
import '../models/comment_model.dart';

abstract class ICommentRepository {
  Future<List<CommentModel>> getPostComment({
    String postId,
    int page,
    int limit,
  });

  Future<BaseResultModel> addComment({String comment});

  Future<BaseResultModel> editComment({String commentId, String newComment});

  Future<BaseResultModel> removeComment({String commentId});
}
