class Config {
  String auth;
  String main;
  Config({this.auth, this.main});
}

Config get getEndpoint {
  String mode = "dev";
  if (mode == "dev") {
    return Config(auth: 'http://192.168.1.37:3000/auth', main: 'http://192.168.1.37:3000/graphql');
  }else return Config(auth: 'https://photo-server.glitch.me/auth', main: 'https://photo-server.glitch.me/graphql');
}
