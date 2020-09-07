class HashTagModel {
  String hashtag;
  int total;
  HashTagModel({this.hashtag, this.total});
  factory HashTagModel.fromMap(Map data) {
    return HashTagModel(hashtag: data['_id'], total: data['count']);
  }
}

class HashTagModels {
  List<HashTagModel> hashtags;
  HashTagModels({this.hashtags});
  factory HashTagModels.fromList(List datas) {
    var _list = <HashTagModel>[];
    try {
      for (var item in datas) {
        _list.add(HashTagModel.fromMap(item));
      }
    } catch (e) {
      _list = [];
    }
    return HashTagModels(hashtags: _list);
  }
}
