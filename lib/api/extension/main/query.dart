import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/schema/schema.dart';

extension MainQuery on GraphQLClient {
  Future<QueryResult> getForumPost(
      {@required String forumId, @required int page, int limit = 10}) async {
    final QueryOptions options = QueryOptions(
        document: gql(GqlSchema.getForumPost.schema),
        variables: <String, dynamic>{
          "forumId": forumId,
          "page": page,
          "limit": limit,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    return this.query(options);
  }

  Future<QueryResult> getForums({@required int page, int limit = 10}) async {
    final QueryOptions options = QueryOptions(
        document: gql(GqlSchema.getForums.schema),
        variables: <String, dynamic>{
          "page": page,
          "limit": limit,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    return this.query(options);
  }

  Future<QueryResult> getPostByHashTag(
      {String hashTag, @required int page, int limit = 10}) async {
    final QueryOptions options = QueryOptions(
        document: gql(GqlSchema.getPostByHashtag.schema),
        variables: <String, dynamic>{
          "hashTag": hashTag,
          "page": page,
          "limit": limit
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    return this.query(options);
  }

  Future<QueryResult> getHashTagStats() async {
    final QueryOptions options = QueryOptions(
        document: gql(GqlSchema.getHashTagStats.schema),
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    return this.query(options);
  }

  Future<QueryResult> getUserBookmark(
      {@required int page, int limit = 10}) async {
    final QueryOptions options = QueryOptions(
        document: gql(GqlSchema.getUserBookmark.schema),
        variables: <String, dynamic>{"page": page, "limit": limit},
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    return this.query(options);
  }

  Future<QueryResult> getPostByCollection(
      {@required String collectionId,
      @required int page,
      int limit = 10}) async {
    final QueryOptions options = QueryOptions(
      document: gql(GqlSchema.getPostByCollection.schema),
      variables: <String, dynamic>{
        "collectionId": collectionId,
        "page": page,
        "limit": limit
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
    return this.query(options);
  }

  Future<QueryResult> getPostComment(
      {@required String postId,
      @required int page,
      int limit = 10,
      String sort = "asc"}) async {
    final QueryOptions options = QueryOptions(
      document: gql(GqlSchema.getPostComment.schema),
      variables: <String, dynamic>{
        "postId": postId,
        "page": page,
        "limit": limit,
        "sort": sort
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
    return this.query(options);
  }
}
