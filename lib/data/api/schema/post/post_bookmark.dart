const postBookmark = r'''
  mutation($postId: String!, $collectionName: String!){
    bookmarkPost(postId: $postId, collectionName: $collectionName){
      status
      success
      message
   }
  }
''';
