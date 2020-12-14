const checkUserName = r'''
  query($name: String!){
    usernameAvailability(name:$name)
  }
''';
