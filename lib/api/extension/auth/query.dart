import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/schema/schema.dart';

extension AuthQuery on GraphQLClient {
  Future<QueryResult> login(
      {@required String username, @required String password}) async {
    final QueryOptions options = QueryOptions(
      document: gql(GqlSchema.login.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, String>{"username": username, "password": password},
    );
    return this.query(options);
  }

  Future<QueryResult> checkNameAvalibility({@required String name}) async {
    final QueryOptions options = QueryOptions(
      document: gql(GqlSchema.checkUserNameAvalibility.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, String>{
        "name": name,
      },
    );
    return this.query(options);
  }
}
