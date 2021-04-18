const forumPost = r'''
  query ($forumId: String!, $page: Int!, $limit: Int!){
      getForumPost(forumId: $forumId, page: $page, limit: $limit){
          _id
          forumId
          title
          userId
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
          createdTime
          isReaction
          isBookmark
          totalComment
          totalReaction
        }
    }
''';
