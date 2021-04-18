import 'package:graphql_flutter/graphql_flutter.dart';

import 'config/connection.dart';

GraphQLClient mainAPI(String token) {
  final HttpLink httpLink = HttpLink(getEndpoint.main,
      defaultHeaders: {"token": token, "guest": "false"});

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}

GraphQLClient get publicAPI {
  final HttpLink httpLink = HttpLink(getEndpoint.pub);

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
   
  );
}

GraphQLClient get guestAPI {
  final HttpLink httpLink =
      HttpLink(getEndpoint.main, defaultHeaders: {"guest": "true"});

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}

GraphQLClient get authAPI {
  final HttpLink httpLink = HttpLink(getEndpoint.auth);

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}
