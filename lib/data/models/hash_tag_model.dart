class HashTagModel {
  String hashtag;
  int total;
  bool isSelected;
  HashTagModel({this.hashtag, this.total, this.isSelected = false});
  factory HashTagModel.fromMap(Map data) {
    return HashTagModel(
      hashtag: data['_id'],
      total: data['count'],
    );
  }
  HashTagModel copyWith({String hashTag, int total, bool isSelected}) {
    return HashTagModel(
      hashtag: hashtag ?? this.hashtag,
      isSelected: isSelected ?? this.isSelected,
      total: total ?? this.total,
    );
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
      return HashTagModels(hashtags: _list);
    } catch (e) {
      return HashTagModels(hashtags: []);
    }
  }
}
