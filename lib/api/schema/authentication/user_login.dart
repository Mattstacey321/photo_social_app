const userLogin = r'''
  query ($username: String!, $password: String!){
      login(username: $username password: $password){
        message
        success
        account_info{
          userId
          name
          avatar
          email
          token      
        }
      }
    }
''';
