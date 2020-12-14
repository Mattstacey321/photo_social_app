class CommentModel {
  String commentId;
  UserCommentInfo user;
  String comment;
  DateTime createdTime;
  CommentModel({this.commentId, this.user, this.comment, this.createdTime});
  factory CommentModel.fromJson(Map data) {
    return CommentModel(
      commentId: data["_id"],
      user: UserCommentInfo.fromJson(data["user"]),
      comment: data["comment"],
      createdTime: DateTime.parse(
        data["createdTime"],
      ),
    );
  }
}

class UserCommentInfo {
  String id;
  String name;
  String avatar;
  UserCommentInfo({this.id, this.name, this.avatar});
  factory UserCommentInfo.fromJson(Map data) {
    return UserCommentInfo(
      id: data["id"],
      name: data["userName"],
      avatar: data["avatar"],
    );
  }
}

class CommentsModel {
  List<CommentModel> comments;
  CommentsModel({this.comments});
  factory CommentsModel.fromList(List data) {
    var comments = <CommentModel>[];
    try {
      for (var item in data) {
        comments.add(CommentModel.fromJson(item));
      }
      return CommentsModel(comments: comments);
    } catch (e) {
      return CommentsModel(comments: []);
    }
  }
}
