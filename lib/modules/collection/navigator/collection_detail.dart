import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../global_widgets/demand_loading.dart';
import '../../../src/app_state/index.dart';
import '../controllers/collection_detail_controller.dart';
import '../widgets/collection_detail_item.dart';

class CollectionDetail extends StatelessWidget {
  final Map<String, dynamic> _info;
  CollectionDetail({Map<String, dynamic> info}) : _info = info;
  @override
  Widget build(BuildContext context) {
    String collectionId = _info != null ? _info["id"] : "";
    //String collectionName = _info != null ? _info["name"] : "...";
    double childAspectRatio = context.width / (context.height * 2);

    return GetBuilder<CollectionDetailController>(
      init: CollectionDetailController(collectionId: collectionId),
      assignId: true,
      id: "collection-detail",
      builder: (controller) => DemandLoadingWidget(
        controller.loadingResult,
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onRefresh: () => controller.refresh(),
              onLoading: () => controller.loadMore(),
              child: GridView.builder(
                padding: EdgeInsets.all(5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: controller.postList.length,
                itemBuilder: (context, index) {
                  return CollectionDetailItem(
                    post: controller.postList[index],
                    onTap: controller.multiSelected.value
                        ? () {
                            //tap to select collection
                            controller.selectItem(index);
                          }
                        : () {},
                    onLongTap: controller.multiSelected.value
                        ? () {}
                        : () {
                            controller.selectItem(index);
                            controller.multipleSelectedMode();
                          },
                  );
                },
              ),
            ),
          ),
        ),
        onEmpty: EmptyCollection(),
        onError: Text("Has Error"),
      ),
      /*Scaffold(
        appBar: CustomAppBar(
          childs: [
            Text(
              collectionName,
              style: AppStyles.appBarTitle,
            ),
          ],
          /*homeIcon: ObxValue(
            (res) => AnimatedSwitcher(
              duration: 100.milliseconds,
              child:
                  res.value ? Icon(EvaIcons.close) : Icon(EvaIcons.arrowBack),
            ),
            controller.multiSelected,
          ),*/
          onTapBack: controller.multiSelected.value
              ? () {
                  controller.cancelMultipleSelectedMode();
                }
              : () {
                  Get.back(id: NestedKey.collection);
                },
        ),
        floatingActionButton: DeletePostButton(),
        body: 
      ),*/
    );
  }
}
