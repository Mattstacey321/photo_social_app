import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/repository/update_repository.dart';
import 'package:photo_social/widgets/custom_button.dart';

class UpdateDialog extends StatelessWidget {
  final bool isNeedUpdate;
  UpdateDialog({this.isNeedUpdate});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (_) {
      return Center(
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 230,
            width: 300,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Current version: ",
                          ),
                          TextSpan(
                            text: _.currentVersion.value,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          /*FutureBuilder(
                          future: _.curentVersion,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("...",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black));
                            } else
                              return TextSpan(
                                  text: snapshot.data,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black));
                          },),*/
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Latest version: ",
                      ),
                      TextSpan(
                        text: _.latestVersion,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        Get.back();
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
                          await UpdateRepository.downloadUpdate();
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
                        ),
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
