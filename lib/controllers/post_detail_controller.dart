import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_social/utils/custom_exception.dart';

class PostDetailController extends GetxController {
  PageController pageController = PageController();
  int pageIndex = 0;
  PostDetailController({this.pageIndex});
  @override
  void onReady() {
    pageController.animateToPage(this.pageIndex,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 200));
  }

  Future<void> saveImage(String fileName, String url) async {
    String downloadFolderPath = "";
    if (await Permission.storage.request() == PermissionStatus.granted) {
      final Directory _appDocDir = await getExternalStorageDirectory();
      final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/Photo_Social/');
      if (await _appDocDirFolder.exists()) {
        //if folder already exists return path
        downloadFolderPath = _appDocDirFolder.path;
      } else {
        //if folder not exists create folder and then return its path
        final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
        downloadFolderPath = _appDocDirNewFolder.path;
      }
      return await FlutterDownloader.enqueue(
        url: url,
        savedDir: downloadFolderPath,
        fileName: fileName,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } else {
      throw PermissionException();
    }
  }
}
