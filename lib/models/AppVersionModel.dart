class AppVersionModel {
  String version;
  String minVersion;
  String donwloadUrl;
  DateTime publishDate;
  AppVersionModel({this.version, this.minVersion, this.donwloadUrl, this.publishDate});
  factory AppVersionModel.fromMap(Map data) {
    return AppVersionModel(
        version: data['version'],
        minVersion: data['min_version'] ?? "",
        donwloadUrl: data['download_url'],
        publishDate: DateTime.parse(data['publishDate']));
  }
}
