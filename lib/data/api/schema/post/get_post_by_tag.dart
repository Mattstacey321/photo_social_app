const postByHashTag = r'''
  query PostByHashTag($hashTag: String!, $page: Int!, $limit: Int!){
      getPostByHashtag(hashTag: $hashTag, page:$page, limit: $limit){
        _id
        title
        forumId
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
