const userRegister = r'''
  mutation ($username: String!, $password: String!, $name: String!, $email: String!){
    register(registerInfo:{
    username: $username,
    password: $password,
    name: $name,
    email: $email
  }){
    message
    success
    account_info{
      name
      avatar
      email
      token
    }
  }
  }
''';
