class Connection {
  String auth;
  String main;
  String pub;
  Connection({this.auth, this.main, this.pub});
}

Connection get getEndpoint {
  String mode = "prod";
  if (mode == "dev") {
    return Connection(
        auth: 'http://192.168.1.16:3000/auth',
        main: 'http://192.168.1.16:3000/graphql',
        pub: 'http://192.168.1.16:3000/public');
  } else
    return Connection(
        auth: 'https://photo-server.glitch.me/auth',
        main: 'https://photo-server.glitch.me/graphql',
        pub: 'https://photo-server.glitch.me/public');
}
