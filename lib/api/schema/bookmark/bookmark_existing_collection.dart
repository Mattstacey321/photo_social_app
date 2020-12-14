const bookmarkExistingCollection = r'''
  mutation($postId: String!, $collectionIds: [String]!){
    bookmarkExistingCollection(postId: $postId, collectionIds:$collectionIds){
    status
    success
    message
  }
}
''';
