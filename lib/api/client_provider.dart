import 'package:graphql_flutter/graphql_flutter.dart';

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
  HttpLink httpLink = HttpLink(uri: "http://192.168.1.37:3000/graphql", headers: {"authentication": token});

  return GraphQLClient(
    cache: cache,
    link: httpLink,
  );
}
GraphQLClient anonymousAPI() {
  HttpLink httpLink = HttpLink(uri: "http://192.168.1.37:3000/graphql", headers: {"anonymous": 'true'});

  return GraphQLClient(
    cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
    link: httpLink,
  );
}

GraphQLClient authAPI() {
  HttpLink httpLink = HttpLink(uri: "http://192.168.1.37:3000/auth");

  return GraphQLClient(
    cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
    link: httpLink,
  );
}