import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../api/schema/schema.dart';

final _gqlSchemea = GqlSchema();

extension AuthQuery on GraphQLClient {
  Future<QueryResult> login({@required String username, @required String password}) async {
    final QueryOptions options = QueryOptions(
      document: gql(_gqlSchemea.login.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, String>{"username": username, "password": password},
    );
    return this.query(options);
  }

  Future<QueryResult> checkNameAvalibility({@required String name}) async {
    final QueryOptions options = QueryOptions(
      document: gql(_gqlSchemea.checkUserNameAvalibility.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, String>{
        "name": name,
      },
    );
    return this.query(options);
  }
}
