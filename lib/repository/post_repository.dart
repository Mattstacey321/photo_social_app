import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/repository/base_repository.dart';

class PostRepository {
  static Future<List<PostModel>> getForumPost(
      {String forumId, int page, int limit}) async {
    var result = await BaseRepository.selectClient
        .getForumPost(forumId: forumId, page: page, limit: limit);
    return PostsModel.fromList((result).data['getForumPost']).posts;
  }

  static Future<bool> likePost({String postId, String forumId}) async {
    var result = await BaseRepository.selectClient
        .likePost(postId: postId, forumId: forumId);
    //return PostsModel.fromList((await result).data['getForumPost']).posts;
  }

  static Future<List<PostModel>> getPostByHashTag(
      {String hashTag, int page, int limit}) async {
    var result = await BaseRepository.selectClient
        .getPostByHashTag(hashTag: hashTag, limit: limit, page: page);
    return PostsModel.fromList((result).data['getPostByHashtag']).posts;
  }
}
