import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/schema/schema.dart';

extension AuthMutation on GraphQLClient {
  Future<QueryResult> register({
    @required String username,
    @required String password,
    @required String name,
    String email = "",
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(GqlSchema.register.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, String>{
        "username": username,
        "password": password,
        "name": name,
        "email": email,
      },
    );
    return this.mutate(options);
  }
}
