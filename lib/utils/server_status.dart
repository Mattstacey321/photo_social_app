enum ServerStatusEnum { offline, online, checking }

extension ServerStatus on ServerStatusEnum {
  static String get offline => "OFFLINE";
  static String get online => "ONLINE";
  static String get checking => "CHECKING";
}
