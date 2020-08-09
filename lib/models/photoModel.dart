class PhotoModel {
  String id;
  String author;
  int width;
  int height;
  String url;
  String downloadUrl;

  PhotoModel({this.id, this.author, this.height, this.width, this.url, this.downloadUrl});
}

class PhotoModels {
  List<PhotoModel> photoModels;
  PhotoModels({this.photoModels});
  factory PhotoModels.fromJson(List list) {
    var photos = <PhotoModel>[];
    for (var photo in list) {
      photos.add(PhotoModel(
          id: photo['id'],
          author: photo['author'],
          height: photo['height'],
          width: photo['width'],
          url: photo['url'],
          downloadUrl: photo['download_url']));
    }
    return PhotoModels(photoModels: photos);
  }
}
