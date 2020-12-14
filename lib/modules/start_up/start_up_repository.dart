import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/extension/index.dart';

class StartUpRepository {
  GraphQLClient _pubClient = Get.find<GraphQL>().pubClient;
  Future<bool> checkServerStatus() async {
    try {
      final queryResult = await _pubClient.checkServerStatus();
      bool result = queryResult.data['status'];
      return result;
    } catch (e) {
      return false;
    }
  }
}
