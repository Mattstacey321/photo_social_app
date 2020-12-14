const getBookmark = r'''
  query($page: Int!, $limit: Int!){   
      getUserBookmark(page:$page, limit:$limit){
        _id
        name
        total
        item{
          postId
          image{
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
        }
      }
    }
''';
