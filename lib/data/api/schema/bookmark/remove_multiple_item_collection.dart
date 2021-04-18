const removePostFromMutipleCollection = r'''
  mutation ($postId: String! , $collectionIds: [String]!){  
    removePostFromMultipleCollection(
      postId: $postId,
      collectionIds: $collectionIds
      ){
      status
      success
      message
    }
  }
''';
