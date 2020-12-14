const getComment = r'''
  query($postId: String!, $page: Int!, $limit: Int!, $sort: SortEnum!){
    getPostComment(postId:$postId, page:$page, limit: $limit, sort:$sort){
    _id
    user{
      id
      userName
      avatar
    }
    comment
    createdTime
  }
  }
''';
