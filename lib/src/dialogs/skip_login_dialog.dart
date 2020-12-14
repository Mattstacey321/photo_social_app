import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/widgets/index.dart';

Future skipLogin() async {
  return Get.dialog(
    SkipLoginDialog(
      onBack: () => Get.back(),
      onSkip: () {
        /*PreferencesController.getPrefs.setBool("isSkipLogin", true);
        PreferencesController.getPrefs.setBool("loginAsGuest", true);
        PreferencesController.getPrefs.setString("token", "");*/
        return Get.offAndToNamed('/home');
      },
    ),
    barrierDismissible: false,
    useRootNavigator: true,
  );
}

class SkipLoginDialog extends StatelessWidget {
  final Function onBack;
  final Function onSkip;
  SkipLoginDialog({@required this.onBack, @required this.onSkip});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 200,
          width: 300,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                EvaIcons.trendingUp,
                size: 35,
              ),
              Text(
                "Almost feature are unlock for guest, but you will need to login to do further action.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              //SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: onBack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Back to login",
                      style: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomButton(
                    onPress: onSkip,
                    tooltip: "Skip now",
                    iconColor: Colors.indigo,
                    backgroundColor: Colors.indigo,
                    childs: [
                      Text(
                        "Skip now",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                  /*RaisedButton(
                    onPressed: () {},
                    child: Text("Skip now"),
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
