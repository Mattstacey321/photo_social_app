import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../modules/authentication/controllers/local_authentication_controller.dart';
import '../api/extension/index.dart';
import '../api/schema/schema.dart';
import '../interface/app_interface.dart';
import '../models/base_result_model.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final _gqlSchema = GqlSchema();
  final GraphQLClient _authClient;
  final LocalAuthentication _localAuthentication;
  AuthRepository({
    @required GraphQLClient authClient,
    @required LocalAuthentication localAuthentication,
  })  : _authClient = authClient,
        _localAuthentication = localAuthentication;

  @override
  Future<BaseResultModel> signIn({
    @required String userName,
    @required String password,
  }) async {
    final schemaName = _gqlSchema.login.name;
    final result = await _authClient.login(username: userName, password: password);
    return BaseResultModel<UserModel>.fromJson(result.data[schemaName]);
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
    final schemaName = _gqlSchema.register.name;
    final result = await _authClient.register(username: username, password: password, name: name);
    return BaseResultModel.fromJson(result.data[schemaName]);
  }

  @override
  Future<bool> checkUserNameAvalibility({String name}) async {
    final schemaName = _gqlSchema.checkUserNameAvalibility.name;
    final result = await _authClient.checkNameAvalibility(name: name);
    return result.data[schemaName];
  }
}
