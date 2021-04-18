import '../models/post_model.dart';

class CollectionModel {
  String postId;
  Media image;
  CollectionModel({this.postId, this.image});
  factory CollectionModel.fromMap(Map data) {
    return CollectionModel(
        postId: data["postId"],
        image: data["image"] != null ? Media.fromMap(data["image"]) : null);
  }
}

class BookmarkCollectionModel {
  String id;
  String name;
  int total;
  List<CollectionModel> item;
  bool isSelected = false;
  BookmarkCollectionModel({this.id, this.name, this.total, this.item});

  factory BookmarkCollectionModel.fromJson(Map data) {
    List<CollectionModel> item = <CollectionModel>[];
    if (data["item"] != null) {
      data["item"].forEach((v) {
        item.add(CollectionModel.fromMap(v));
      });
    }
    return BookmarkCollectionModel(
      id: data["_id"],
      name: data["name"],
      total: data["total"],
      item: item,
    );
  }
}

class BookmarkCollectionsModel {
  List<BookmarkCollectionModel> collections;
  BookmarkCollectionsModel({this.collections});
  factory BookmarkCollectionsModel.fromList(List data) {
    var collections = <BookmarkCollectionModel>[];
    try {
      for (var item in data) {
        collections.add(BookmarkCollectionModel.fromJson(item));
      }
      return BookmarkCollectionsModel(collections: collections);
    } catch (e) {
      return BookmarkCollectionsModel(collections: []);
    }
  }
}
