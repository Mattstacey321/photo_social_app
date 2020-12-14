import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/schema/schema.dart';

extension MainMutation on GraphQLClient {
  Future<QueryResult> reactionPost(
      {@required String postId, @required String forumId, String type}) async {
    final MutationOptions options = MutationOptions(
      document: gql(GqlSchema.reactionPost.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, dynamic>{
        "forumId": forumId,
        "postId": postId,
        "reactionType": type
      },
    );
    return this.mutate(options);
  }

  Future<QueryResult> bookmarkPost(
      {@required String postId, @required String collectionName}) async {
    final MutationOptions options = MutationOptions(
      document: gql(GqlSchema.bookmarkPost.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, dynamic>{
        "postId": postId,
        "collectionName": collectionName
      },
    );
    return this.mutate(options);
  }

  Future<QueryResult> removeCollections(
      {@required List<String> collectionIds}) async {
    final MutationOptions options = MutationOptions(
      document: gql(GqlSchema.removeCollections.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, dynamic>{
        "collectionIds": collectionIds,
      },
    );
    return this.mutate(options);
  }

  Future<QueryResult> removeCollectionItem(
      {@required String collectionId, @required List<String> postIds}) async {
    final MutationOptions options = MutationOptions(
      document: gql(GqlSchema.removeCollectionItem.schema),
      fetchPolicy: FetchPolicy.noCache,
      variables: <String, dynamic>{
        "collectionId": collectionId,
        "postIds": postIds
      },
    );
    return this.mutate(options);
  }

  Future<QueryResult> bookmarkExistingCollection(
      {@required String postId, @required List<String> collectionIds}) async {
    final QueryOptions options = QueryOptions(
      document: gql(GqlSchema.boomarkToExistingCollection.schema),
      variables: <String, dynamic>{
        "postId": postId,
        "collectionIds": collectionIds
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    return this.query(options);
  }

  Future<QueryResult> removePostFromMultipleCollection(
      {@required String postId, @required List<String> collectionIds}) async {
    final QueryOptions options = QueryOptions(
      document: gql(GqlSchema.removeMultipleItemFromCollection.schema),
      variables: <String, dynamic>{
        "postId": postId,
        "collectionIds": collectionIds
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    return this.query(options);
  }
}
