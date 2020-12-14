import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/schema/public/check_latest.dart';

extension PubQuery on GraphQLClient {
  Future<QueryResult> checkLatest() async {
    final QueryOptions options = QueryOptions(
      document: gql(checkAppLatest),
    );

    return this.query(options);
  }

  Future<QueryResult> checkServerStatus() async {
    final String checkServerStatus = """
      query{
          status
        } 
    """;
    return this.query(QueryOptions(
        document: gql(checkServerStatus), fetchPolicy: FetchPolicy.noCache));
  }
}
