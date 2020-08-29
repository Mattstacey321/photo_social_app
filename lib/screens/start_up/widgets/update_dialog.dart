import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/widgets/custom_button.dart';

class UpdateDialog extends StatelessWidget {
  final bool isNeedUpdate;
  UpdateDialog({this.isNeedUpdate});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartUpController>(builder: (_) {
      return Center(
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200,
            width: 300,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  EvaIcons.cloudDownload,
                  size: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "There is an update now. Do you want to update ?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Current version: ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: _.curentVersion,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black))
                    ])),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Latest version: ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: _.latestVersion,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black))
                    ]))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        _.goToDestinationPage();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Install later",
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomButton(
                      onPress: () async {
                        try {
                          await _.downloadUpdate();
                        } catch (e) {
                          print(e);
                          BotToast.showSimpleNotification(
                              title: "Download fail. Try again");
                        }
                      },
                      tooltip: "Update now",
                      iconColor: Colors.indigo,
                      radius: 10,
                      width: 95,
                      backgroundColor: Colors.indigo,
                      childs: [
                        Text(
                          "Update now",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
