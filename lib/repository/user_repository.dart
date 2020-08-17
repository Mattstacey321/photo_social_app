import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/constraint.dart';

class UserRepository {
  static GraphQLClient _authClient =  GraphQL().authClient();

  static String signInAsGuest() {
    return AppConstraint.defaultAvatar;
  }

  static Future signIn({String username, String password}) async {
    return (_authClient).login(username: username, password: password);
  }

  static Future signUp({String username, String password}) async {
    return (_authClient).register(username: username, password: password);
  }
}
