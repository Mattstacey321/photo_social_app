import 'dart:ffi';

class PostModel {
  String postId;
  String postTitle;
  List<Media> medias;
  List tags;
  int totalLike;
  int totalComment;
  DateTime createdTime;
  int get countMedia => medias.length;

  PostModel(
      {this.postId,
      this.postTitle,
      this.tags,
      this.medias,
      this.createdTime,
      this.totalLike,
      this.totalComment});
  factory PostModel.fromMap(Map post) {
    return PostModel(
        postId: post['_id'],
        postTitle: post['title'],
        tags: post['tag'],
        createdTime: DateTime.parse(post['created_time']),
        medias: Medias.fromList(post['media']).medias);
  }
}

class Media {
  String original;
  String id;
  String name;
  Float size; //in Kb
  String thumb1;
  String thumb2;
  String format;
  Media({this.original, this.id, this.name, this.size, this.thumb1, this.thumb2, this.format});

  factory Media.fromMap(Map data) {
    try {
      return Media(
          id: data['id'],
          format: data['format'],
          name: data['name'],
          original: data['original'],
          size: data['size'],
          thumb1: data['thumb1'],
          thumb2: data['thumb2']);
    } catch (e) {
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
