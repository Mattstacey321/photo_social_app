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
    try {
      for (var forum in data) {
        _forums.add(ForumModel(id: forum['id'], banner: forum['banner'], name: forum['name']));
      }
    } catch (e) {
      print(e);
      return Forums(forums: []);
    }
    return Forums(forums: _forums);
  }
}
