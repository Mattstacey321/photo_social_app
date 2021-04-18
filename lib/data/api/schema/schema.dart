import '../../models/graphql_model.dart';
import 'authentication/name_availability.dart';
import 'authentication/user_login.dart';
import 'authentication/user_register.dart';
import 'bookmark/bookmark_existing_collection.dart';
import 'bookmark/get_bookmark.dart';
import 'bookmark/remove_collection_item.dart';
import 'bookmark/remove_collections.dart';
import 'bookmark/remove_multiple_item_collection.dart';
import 'comment/get_comment.dart';
import 'forum/get_all_forum.dart';
import 'hashtag/get_hash_tag.dart';
import 'post/get_forum_post.dart';
import 'post/get_post_by_collection.dart';
import 'post/get_post_by_tag.dart';
import 'post/post_bookmark.dart';
import 'post/post_reaction.dart';

class GqlSchema {
  GraphqlModel getForumPost = GraphqlModel(
    name: "getForumPost",
    schema: forumPost,
  );
  GraphqlModel getPostByCollection = GraphqlModel(
    name: "getPostByCollection",
    schema: postCollection,
  );
 GraphqlModel getPostByHashtag = GraphqlModel(
    name: "getPostByHashtag",
    schema: postByHashTag,
  );
  GraphqlModel bookmarkPost = GraphqlModel(
    name: "bookmarkPost",
    schema: postBookmark,
  );
  GraphqlModel reactionPost = GraphqlModel(
    name: "reactionPost",
    schema: postReaction,
  );
  GraphqlModel checkLatest = GraphqlModel(
    name: "checkLatest",
    schema: postBookmark,
  );
  GraphqlModel getHashTagStats = GraphqlModel(
    name: "getHashTagStats",
    schema: getHashTag,
  );
  GraphqlModel getForums = GraphqlModel(
    name: "getForums",
    schema: getAllForums,
  );
  GraphqlModel getPostComment = GraphqlModel(
    name: "getPostComment",
    schema: getComment,
  );
  GraphqlModel getUserBookmark = GraphqlModel(
    name: "getUserBookmark",
    schema: getBookmark,
  );
  GraphqlModel login = GraphqlModel(
    name: "login",
    schema: userLogin,
  );
  GraphqlModel register = GraphqlModel(
    name: "register",
    schema: userRegister,
  );
  GraphqlModel removeCollections = GraphqlModel(
    schema: collectionsRemove,
    name: "removeCollections",
  );
  GraphqlModel removeCollectionItem = GraphqlModel(
    schema: collectionItemRemove,
    name: "removeCollectionItem",
  );
  GraphqlModel boomarkToExistingCollection = GraphqlModel(
    schema: bookmarkExistingCollection,
    name: "bookmarkExistingCollection",
  );
  GraphqlModel checkUserNameAvalibility = GraphqlModel(
    schema: checkUserName,
    name: "usernameAvailability",
  );
  GraphqlModel removeMultipleItemFromCollection = GraphqlModel(
      schema: removePostFromMutipleCollection,
      name: "removePostFromMultipleCollection");
}
