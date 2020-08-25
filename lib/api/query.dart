import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:photo_social/api/client_provider.dart';

class GraphQL {
  GraphQLClient authClient()  =>  authAPI();
  GraphQLClient mainClient(String token)  =>  mainAPI(token);
  GraphQLClient guestClient()  =>  anonymousAPI();
  GraphQLClient pubClient()  =>  pubAPI();
}

extension AuthQuery on GraphQLClient {

  Future<QueryResult> login({String username, String password}) async {
    final String login = """
      query{
          login(username:"$username" password:"$password")
        }
    """;
    return this.query(QueryOptions(documentNode: gql(login)));
  }
  Future<QueryResult> register({String username, String password}) async {
    final String login = """
      mutation{
          register(username:"$username",password:"$password"){
                status
                success
                message
          }
        }
    """;
    return this.query(QueryOptions(documentNode: gql(login)));
  }

}

extension GqlQuery on GraphQLClient {
  Future<QueryResult> getForumPost({String forumId, int page = 1, int limit = 10}) async {
    final String getForumPost = """
      query{
        getForumPost(forumId:"$forumId",page:$page,limit:$limit){
            _id
            title
            user_id
            content
            media{
              id
              original
              thumb1
              thumb2
              format
              name
              size
              blur_hash
              height
              width
            }
            tag
            created_time
            total_comment
            total_reaction
          }
      }
    """;
    return this.query(QueryOptions(documentNode: gql(getForumPost)));
  }

  Future<QueryResult> getForums({int page = 1, int limit = 10}) async {
    final String getForums = """
      query{
        getForums(page:$page,limit:$limit){
          _id
          name
          banner
        }
      }
    """;
    return this.query(QueryOptions(documentNode: gql(getForums)));
  }
  Future<QueryResult> countForumPost({String forumId}) async {
    final String countForumPost = """
      query{
        countForumPost(forumId:"$forumId")
      }
    """;
    return this.query(QueryOptions(documentNode: gql(countForumPost)));
  }
  
   Future<QueryResult> likePost({String postId,String forumId}) async {
    final String likePost = """
      mutation{
          likePost(forumId:"$forumId",postId:"$postId"){
                status
                success
                message
          }
        }
    """;
    return this.query(QueryOptions(documentNode: gql(likePost)));
  }
   Future<QueryResult> checkLatest({String currentVersion}) async {
    final String checkLatest = """
      query{
           checkLatest{
              download_url
              version
              publishDate
            }
        }
    """;
    return this.query(QueryOptions(documentNode: gql(checkLatest)));
  }
   Future<QueryResult> checkServerStatus() async {
    final String checkServerStatus = """
      query{
          status
        }
    """;
    return this.query(QueryOptions(documentNode: gql(checkServerStatus)));
  }
}
