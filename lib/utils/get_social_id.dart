class _SocialID {
  String type;
  String id;
  _SocialID({this.type, this.id});
}

List<_SocialID> getUserSocial(String data) {
  var array = <_SocialID>[];
  var s = data.trim().split(RegExp('\\s+'));
  try {
    for (var i = 0; i < s.length; i++) {
      if (i % 2 == 0) {
        if (s[i] == 'ig:') {
          array.add(_SocialID(type: 'ig', id: s[i + 1]));
        }
        if (s[i] == 'fb:') {
          array.add(_SocialID(type: 'fb', id: s[i + 1]));
        }
        if (s[i] == 'tw:') {
          array.add(_SocialID(type: 'tw', id: s[i + 1]));
        }
      }
    }
    return array;
  } catch (e) {
    return array;
  }
}
