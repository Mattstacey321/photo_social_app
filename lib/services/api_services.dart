import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_social/models/photoModel.dart';

import '../constraint.dart';

class ApiServices {
  static Future<List<PhotoModel>> getData({@required int page}) async {
    Response response = await Dio().get(AppConstraint.sampleAPI(page: page));
    print("debug: ${response.data}");
    return PhotoModels.fromJson(response.data).photoModels;
  }
}
