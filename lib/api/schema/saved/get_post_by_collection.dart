const getPostCollection = r'''
   query($collectionId: String!, $page: Int!, $limit: Int!){   
         getPostByCollection(collectionId:$collectionId, page:$page, limit:$limit){
            _id
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
            totalComment
            totalReaction
         }
        }
''';
