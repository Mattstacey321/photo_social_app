const collectionsRemove = r'''
  mutation($collectionIds: [String]!){
    removeCollections(collectionIds:$collectionIds){
      status
      success
      message
    }
}
''';
