class Config {
  String auth;
  String main;
  String pub;
  Config({this.auth, this.main,this.pub});
}

Config get getEndpoint {
  String mode = "prod";
  if (mode == "dev") {
    return Config(
        auth: 'http://192.168.1.16:3000/auth',
        main: 'http://192.168.1.16:3000/graphql',
        pub: 'http://192.168.1.16:3000/public');
  } else
    return Config(
        auth: 'https://photo-server.glitch.me/auth',
        main: 'https://photo-server.glitch.me/graphql',
        pub: 'https://photo-server.glitch.me/public');
}
