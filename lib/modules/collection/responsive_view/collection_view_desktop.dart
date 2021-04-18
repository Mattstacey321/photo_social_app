import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/themes/app_styles.dart';
import '../../../data/utils/nested_key.dart';
import '../../../global_widgets/demand_loading.dart';
import '../../../src/app_state/index.dart';
import '../controllers/collection_controller.dart';
import '../widgets/collection_item.dart';

class CollectionViewDesktop extends GetView<CollectionController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(10),
        child: Center(
            child: DemandLoadingWidget(
          controller.loadingResult,
          child: SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            cacheExtent: 200,
            onRefresh: () => controller.refresh(),
            onLoading: () => controller.loadMore(),
            child: GridView.builder(
              itemCount: controller.collectionLength,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: GetPlatform.isMobile ? 2 : 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: context.width / (context.height + 150) ,
              ),
              itemBuilder: (context, index) {
                final collections = controller.collections[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ObxValue(
                      (res) => Expanded(
                        child: CollectionItem(
                          height: context.height,
                          width: context.width,
                          collection: collections,
                          onLongTap: res.value
                              ? () {}
                              : () {
                                  controller.selectItem(index);
                                  controller.multipleSelectedMode();
                                },
                          onTap: res.value
                              ? () {
                                  //tap to select collection
                                  controller.selectItem(index);
                                }
                              : () {
                                  Get.toNamed(
                                    "/collection-detail",
                                    id: NestedKey.collection,
                                    arguments: <String, dynamic>{
                                      "id": collections.id,
                                      "name": collections.name
                                    },
                                  );
                                },
                        ),
                      ),
                      controller.multiSelected,
                    ),
                    SizedBox(height: 10),
                    Text(
                      collections.name,
                      style: AppStyles.collectionName,
                    )
                  ],
                );
              },
            ),
          ),
          onEmpty: EmptyCollection(),
          onError: Text("Error"),
        )),
      );
      //TODO: scaffold collection 
    /*Scaffold(
      /*appBar: CustomAppBar(
        childs: [
          Text(
            "My Collection",
            style: AppStyles.appBarTitle,
          ),
        ],
        /*homeIcon: ObxValue<RxBool>(
          (res) => AnimatedSwitcher(
            duration: 100.milliseconds,
            child: res.value
                ? CircleIcon(
                    onTap: () {
                      controller.cancelMultipleSelectedMode();
                    },
                    tooltip: "Cancel",
                    icon: Icon(EvaIcons.close))
                : Icon(EvaIcons.arrowBack),
          ),
          controller.multiSelected,
        ),*/
        /*onTapBack: () {
          //TODO: Navigation collection
          /*BaseController.to
            .changePage(BaseController.to.currentIndex.value - 1)*/
        },*/
      ),*/
      
      body: 
    );*/
  }
}