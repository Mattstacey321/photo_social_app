import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/utils/custom_exception.dart';

class PostDetailController extends GetxController {
  int _imageIndex = 0;
  PostDetailController({String postId, int imageIndex}) : _imageIndex = imageIndex;
  var pageController = PageController();
  var hideComment = false.obs;
  var currentImageIndex = 0.obs;

  @override
  void onReady() {
    pageController.animateToPage(_imageIndex,
        curve: Curves.fastLinearToSlowEaseIn, duration: Duration(milliseconds: 200));
    currentImageIndex(_imageIndex);
    super.onReady();
  }

  Future<void> downloadImage(String fileName, String url) async {
    String downloadFolderPath = "";
    if (await Permission.storage.request() == PermissionStatus.granted) {
      final Directory _appDocDir = await getExternalStorageDirectory();
      final Directory _appDocDirFolder = Directory('${_appDocDir.path}/Photo_Social/');
      if (await _appDocDirFolder.exists()) {
        //if folder already exists return path
        downloadFolderPath = _appDocDirFolder.path;
      } else {
        //if folder not exists create folder and then return its path
        final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
        downloadFolderPath = _appDocDirNewFolder.path;
      }
      return await FlutterDownloader.enqueue(
        url: url,
        savedDir: downloadFolderPath,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      throw PermissionException();
    }
  }

  void copyLink(String url) {
    Clipboard.setData(new ClipboardData(text: url))
        .then((value) => BotToast.showText(text: "Copy url success"))
        .catchError((err) {
      BotToast.showText(text: "Copy fail");
    });
  }

  void hideCommentArea() {
    hideComment.toggle();
  }

  void setGaleryImageIndex(int index) {
    currentImageIndex(index);
  }

  void navigateLeft() {
    currentImageIndex.value == 0
        ? null
        : pageController.animateToPage(currentImageIndex.value - 1,
            duration: 200.milliseconds, curve: Curves.easeIn);
  }

  void navigateRight() {
    pageController.animateToPage(currentImageIndex.value + 1,
        duration: 200.milliseconds, curve: Curves.easeIn);
  }
}
//  try {
//                         _
//                             .saveImage(media[index].name, media[index].original)
//                             .then((value) => BotToast.showText(text: "Download finished"))
//                             .catchError((err) => BotToast.showText(text: "Download failed"));
//                       } on PermissionException {
//                         BotToast.showText(
//                             text: "You must granted storage permission to download image",
//                             duration: Duration(seconds: 1));
//                       }
