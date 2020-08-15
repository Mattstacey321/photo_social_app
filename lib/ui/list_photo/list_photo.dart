import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/photoModel.dart';
import 'package:photo_social/services/api_services.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_appBar.dart';

class ListPhoto extends StatefulWidget {
  @override
  _ListPhotoState createState() => _ListPhotoState();
}

class _ListPhotoState extends State<ListPhoto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [Text("Demo",style: AppStyle.appBarTitle,)],
        height: 50,
        onTap: () {
          Get.back();
        },
        homeIcon: Icon(FeatherIcons.arrow_left),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: FutureBuilder<List<PhotoModel>>(
          future: ApiServices.getData(page: 1),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitCubeGrid(
                color: Colors.black,
                size: 15,
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text("No data"),
              );
            } else {
              var photos = snapshot.data;
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    width: 200,
                    color: Colors.indigo,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
