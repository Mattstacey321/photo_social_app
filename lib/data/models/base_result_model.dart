import '../models/user_model.dart';

class BaseResultModel<T> {
  int status;
  bool success;
  String message;
  T data;
  BaseResultModel({this.status, this.success, this.message, this.data});

  BaseResultModel.fail(this.status, this.success, this.message, this.data);

  factory BaseResultModel.fromJson(Map data) {
    if (T == UserModel) {
      return BaseResultModel(
        status: data["status"],
        success: data["success"],
        message: data["message"],
        data: UserModel.fromJson(data["account_info"]) as T,
      );
    } else
      return BaseResultModel(
        status: data["status"],
        success: data["success"],
        message: data["message"],
        data: data["data"],
      );
    /*return (data["data"] == null || data["account_info"] == null)
        ? BaseResultModel.fail(
            data["status"],
            data["success"],
            data["message"],
            null,
          )
        : BaseResultModel(
            status: data["status"],
            success: data["success"],
            message: data["message"],
            data: data["data"],
          );*/
  }
}
