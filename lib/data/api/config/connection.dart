class Connection {
  String auth;
  String main;
  String pub;
  Connection({this.auth, this.main, this.pub});
}

Connection get getEndpoint {
  String mode = "prod";
  if (mode == "dev") {
    String baseUrl = "http://192.168.123.107:8080";
    //String baseUrl = "https://dhpro-8ef6063b.localhost.run";
    return Connection(
      auth: baseUrl + '/auth',
      main: baseUrl + '/graphql',
      pub: baseUrl + '/public',
    );
  } else
    return Connection(
        auth: 'https://photo-server.glitch.me/auth',
        main: 'https://photo-server.glitch.me/graphql',
        pub: 'https://photo-server.glitch.me/public');
}
