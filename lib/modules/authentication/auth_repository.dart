import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/api/extension/index.dart';
import 'package:photo_social/interface/app_interface.dart';
import 'package:photo_social/models/base_result_model.dart';
import 'package:photo_social/models/user_model.dart';

import '../local_authentication/local_authentication_controller.dart';

class AuthRepository implements IAuthRepository {
  GraphQLClient _authClient = Get.find<GraphQL>().authClient;
  LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  Future<BaseResultModel> signIn({
    @required String userName,
    @required String password,
  }) async {
    final result =
        await _authClient.login(username: userName, password: password);
    return BaseResultModel<UserModel>.fromJson(
        result.data[GqlSchema.login.name]);
  }

  @override
  Future signOut() async {
    _localAuthentication.clearSession();
  }

  @override
  Future<BaseResultModel> signUp({
    @required String username,
    @required String password,
    @required String name,
  }) async {
    final result = await _authClient.register(
        username: username, password: password, name: name);
    return BaseResultModel.fromJson(result.data[GqlSchema.register.name]);
  }

  @override
  Future<bool> checkUserNameAvalibility({String name}) async {
    final result = await _authClient.checkNameAvalibility(name: name);
    return result.data[GqlSchema.checkUserNameAvalibility.name];
  }
}
