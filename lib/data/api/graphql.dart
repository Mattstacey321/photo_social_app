import 'package:graphql_flutter/graphql_flutter.dart';

import 'client_provider.dart';

class GraphQL {
  final bool _isGuest;
  final String _token;
  GraphQL({bool isGuest, String token})
      : assert(isGuest != null),
        _isGuest = isGuest,
        _token = token;
  GraphQLClient get authClient => authAPI;
  GraphQLClient get pubClient => publicAPI;
  GraphQLClient get selectClient => _isGuest ? guestAPI : mainAPI(_token);
  /*{
    if (_isGuest) {
      return guestAPI;
    } else
      return mainAPI(_token);
  }*/
}
