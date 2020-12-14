import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/config/connection.dart';

GraphQLClient mainAPI(String token) {
  HttpLink httpLink = HttpLink(getEndpoint.main,
      defaultHeaders: {"token": token, "guest": "false"});

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}

GraphQLClient get pubAPI {
  HttpLink httpLink = HttpLink(getEndpoint.pub);

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}

GraphQLClient get guestAPI {
  HttpLink httpLink =
      HttpLink(getEndpoint.main, defaultHeaders: {"guest": "true"});

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}

GraphQLClient get authAPI {
  HttpLink httpLink = HttpLink(getEndpoint.auth);

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );
}
