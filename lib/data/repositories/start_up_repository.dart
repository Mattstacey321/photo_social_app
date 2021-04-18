import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/extension/index.dart';
class StartUpRepository {
  final GraphQLClient _pubClient;
  StartUpRepository({@required GraphQLClient pubClient}) : _pubClient = pubClient;

  Future<bool> checkServerStatus() async {
    try {
      final queryResult = await _pubClient.checkServerStatus();
      bool result = queryResult.data['status'];
      return result;
    } catch (_) {
      return false;
    }
  }
}
