import 'package:photo_social/models/graphql_model.dart';

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
  static GraphqlModel getForumPost = GraphqlModel(
    name: "getForumPost",
    schema: forumPost,
  );
  static GraphqlModel getPostByCollection = GraphqlModel(
    name: "getPostByCollection",
    schema: postCollection,
  );
  static GraphqlModel getPostByHashtag = GraphqlModel(
    name: "getPostByHashtag",
    schema: postByHashTag,
  );
  static GraphqlModel bookmarkPost = GraphqlModel(
    name: "bookmarkPost",
    schema: postBookmark,
  );
  static GraphqlModel reactionPost = GraphqlModel(
    name: "reactionPost",
    schema: postReaction,
  );
  static GraphqlModel checkLatest = GraphqlModel(
    name: "checkLatest",
    schema: postBookmark,
  );
  static GraphqlModel getHashTagStats = GraphqlModel(
    name: "getHashTagStats",
    schema: getHashTag,
  );
  static GraphqlModel getForums = GraphqlModel(
    name: "getForums",
    schema: getAllForums,
  );
  static GraphqlModel getPostComment = GraphqlModel(
    name: "getPostComment",
    schema: getComment,
  );
  static GraphqlModel getUserBookmark = GraphqlModel(
    name: "getUserBookmark",
    schema: getBookmark,
  );
  static GraphqlModel login = GraphqlModel(
    name: "login",
    schema: userLogin,
  );
  static GraphqlModel register = GraphqlModel(
    name: "register",
    schema: userRegister,
  );
  static GraphqlModel removeCollections = GraphqlModel(
    schema: collectionsRemove,
    name: "removeCollections",
  );
  static GraphqlModel removeCollectionItem = GraphqlModel(
    schema: collectionItemRemove,
    name: "removeCollectionItem",
  );
  static GraphqlModel boomarkToExistingCollection = GraphqlModel(
    schema: bookmarkExistingCollection,
    name: "bookmarkExistingCollection",
  );
  static GraphqlModel checkUserNameAvalibility = GraphqlModel(
    schema: checkUserName,
    name: "usernameAvailability",
  );
  static GraphqlModel removeMultipleItemFromCollection = GraphqlModel(
      schema: removePostFromMutipleCollection,
      name: "removePostFromMultipleCollection");
}
