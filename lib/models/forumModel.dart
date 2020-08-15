class ForumModel {
  String id;
  String name;
  String banner;
  ForumModel({this.id, this.name, this.banner});
  factory ForumModel.fromMap(Map forum) {
    return ForumModel(id: forum['_id'], banner: forum['banner'], name: forum['name']);
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
    } catch (e) {
      return Forums(forums: []);
    }
    return Forums(forums: _forums);
  }
}
