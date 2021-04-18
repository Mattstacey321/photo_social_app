class ForumModel {
  String id;
  String name;
  String banner;
  int totalPost;
  ForumModel({this.id, this.name, this.banner, this.totalPost});
  factory ForumModel.fromMap(Map forum) {
    return ForumModel(
      id: forum['_id'],
      banner: forum['banner'],
      name: forum['name'],
      totalPost: forum['totalPost'],
    );
  }
}

class Forums {
  List<ForumModel> forums;
  Forums({this.forums});
  factory Forums.fromList(List data) {
    var _forums = <ForumModel>[];
    try {
      for (var forum in data) {
        _forums.add(ForumModel.fromMap(forum));
      }
      return Forums(forums: _forums);
    } catch (e) {
      return Forums(forums: []);
    }
  }
}
