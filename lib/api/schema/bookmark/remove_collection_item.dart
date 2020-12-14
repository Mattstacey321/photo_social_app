const collectionItemRemove = r'''
  mutation($collectionId:String!, $postIds: [String]!){
    removeCollectionItem(collectionId: $collectionId,postIds: $postIds){
      status
      success
      message
      payload
    }
  }
''';
