class AppVersionModel {
  String version;
  String minVersion;
  String donwloadUrl;
  String fileName;
  DateTime publishDate;
  AppVersionModel({this.version, this.minVersion, this.fileName,this.donwloadUrl, this.publishDate});
  factory AppVersionModel.fromMap(Map data) {
    return AppVersionModel(
        version: data['version'],
        minVersion: data['min_version'] ?? "",
        donwloadUrl: data['download_url'],
        fileName: data['file_name'],
        publishDate: DateTime.parse(data['publishDate']));
  }
}
