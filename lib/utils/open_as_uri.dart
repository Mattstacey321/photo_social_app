import 'package:bot_toast/bot_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWith {
  static void _launchApp([String url, String fallbackUrl = ""]) async {
    try {
      bool launched = await launch(url,
          forceSafariVC: false, forceWebView: false, enableJavaScript: true);
      if (!launched) {
        await launch(fallbackUrl,
            forceSafariVC: false, forceWebView: false, enableJavaScript: true);
      }
    } catch (e) {
      //BotToast.showText(text: "Can not open link. Try again");
      await launch(fallbackUrl,
              forceSafariVC: false, forceWebView: false, enableJavaScript: true)
          .catchError((err) => BotToast.showText(text: "Can not open url"));
    }
  }

  static void facebook({String id = ""}) async {
    String url = "https://www.facebook.com/$id";
    String fallbackUrl = "fb://profile/$id";
    _launchApp(url, fallbackUrl);
  }

  static void instagram({String id = ""}) async {
    String url = "https://www.instagram.com/$id";
    _launchApp(url);
  }

  static void twitter({String id = ""}) async {
    String url = "https://twitter.com/$id";
    _launchApp(url);
  }

  static void weibo({String id = ""}) async {
    String url = "https://weibo.com/u/$id";
    _launchApp(url);
  }
}
