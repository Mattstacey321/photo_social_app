import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/config.dart';

String uuidFromObject(Object object) {
  if (object is Map<String, Object>) {
    final String typeName = object['__typename'] as String;
    final String id = object['id'].toString();
    if (typeName != null && id != null) {
      return <String>[typeName, id].join('/');
    }
  }
  return null;
}

final OptimisticCache cache = OptimisticCache(
  dataIdFromObject: uuidFromObject,
);

GraphQLClient mainAPI(String token) {
  HttpLink httpLink =
      HttpLink(uri: getEndpoint.main, headers: {"authentication": token});

  return GraphQLClient(
    cache: cache,
    link: httpLink,
  );
}

GraphQLClient get pubAPI {
  HttpLink httpLink = HttpLink(uri: getEndpoint.pub);

  return GraphQLClient(
    cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
    link: httpLink,
  );
}

GraphQLClient get anonymousAPI {
  HttpLink httpLink =
      HttpLink(uri: getEndpoint.main, headers: {"guest": 'true'});

  return GraphQLClient(
    cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
    link: httpLink,
  );
}

GraphQLClient get authAPI {
  HttpLink httpLink = HttpLink(uri: getEndpoint.auth);

  return GraphQLClient(
    cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
    link: httpLink,
  );
}
