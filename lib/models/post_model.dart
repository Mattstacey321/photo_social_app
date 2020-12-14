class PostModel {
  String postId;
  String forumId;
  String userId;
  String postTitle;
  List<Media> medias;
  List tags;
  int totalReaction;
  int totalComment;
  DateTime createdTime;
  bool isReactioned;
  bool isBookmarked;
  bool isSelected = false;
  int get countMedia => medias.length;

  PostModel(
      {this.postId,
      this.forumId,
      this.userId,
      this.postTitle,
      this.tags,
      this.medias,
      this.createdTime,
      this.totalReaction,
      this.totalComment,
      this.isReactioned,
      this.isBookmarked});
  factory PostModel.fromMap(Map post) {
    return PostModel(
        forumId: post["forumId"],
        postId: post['_id'],
        postTitle: post['title'],
        tags: post['tag'],
        createdTime: DateTime.parse(post['createdTime']),
        medias: Medias.fromList(post['media']).medias,
        totalReaction: post['totalReaction'] ?? 0,
        totalComment: post['totalComment'] ?? 0,
        isReactioned: post["isReaction"] ?? false,
        isBookmarked: post["isBookmark"]);
  }
}

class Media {
  String original;
  String id;
  String name;
  int size; //in Kb
  String blurHash;
  double height;
  double width;
  String thumb1;
  String thumb2;
  String format;
  Media(
      {this.original,
      this.id,
      this.name,
      this.size,
      this.blurHash,
      this.height,
      this.width,
      this.thumb1,
      this.thumb2,
      this.format});

  factory Media.fromMap(Map data) {
    try {
      return Media(
          id: data['id'],
          format: data['format'],
          name: data['name'],
          original: data['original'],
          size: data['size'],
          blurHash: data['blur_hash'] ??= "",
          height: data['height'].toDouble(),
          width: data['width'].toDouble(),
          thumb1: data['thumb1'],
          thumb2: data['thumb2']);
    } catch (e) {
      print(e);
      return Media();
    }
  }
}

class Medias {
  List<Media> medias;
  Medias({this.medias});
  factory Medias.fromList(List data) {
    var _medias = <Media>[];
    try {
      for (var media in data) {
        _medias.add(Media.fromMap(media));
      }
    } catch (e) {
      return Medias(medias: []);
    }
    return Medias(medias: _medias);
  }
}

class PostsModel {
  List<PostModel> posts;
  PostsModel({this.posts});
  factory PostsModel.fromList(List data) {
    var _posts = <PostModel>[];
    try {
      for (var post in data) {
        _posts.add(PostModel.fromMap(post));
      }
    } catch (e) {
      print(e);
      return PostsModel(posts: []);
    }
    return PostsModel(posts: _posts);
  }
}
