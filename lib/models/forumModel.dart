class ForumModel {
  String id;
  String name;
  String banner;
  ForumModel({this.id, this.name, this.banner});
}

class Forums {
  List<ForumModel> forums;
  Forums({this.forums});
  factory Forums.fromList(List data) {
    var _forums = <ForumModel>[];
    for (var forum in data) {
      _forums.add(forum);
    }
    return Forums(forums: _forums);
  }
}
