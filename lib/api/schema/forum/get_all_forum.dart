const getAllForums = r'''
   query($page: Int!, $limit: Int!){
        getForums(page:$page, limit:$limit){
          _id
          name
          banner
          totalPost
        }
      }
''';
