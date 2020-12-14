import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';
import 'package:photo_social/modules/collection/collection_controller.dart';
import 'package:photo_social/modules/collection/widgets/collection_item.dart';
import 'package:photo_social/modules/collection/widgets/delete_collection_button.dart';
import 'package:photo_social/src/app_state/index.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/utils/nested_key.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Collections extends GetView<CollectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [
          Text(
            "My Collection",
            style: AppStyles.appBarTitle,
          ),
          Spacer(),
        ],
        homeIcon: ObxValue(
            (res) => AnimatedSwitcher(
                  duration: 100.milliseconds,
                  child: res.value
                      ? CircleIcon(
                          onTap: () {
                            controller.cancelMultipleSelectedMode();
                          },
                          child: Icon(EvaIcons.close))
                      : Icon(EvaIcons.arrowBack),
                ),
            controller.multiSelected),
        onTapBack: () => BaseController.to
            .changePage(BaseController.to.currentIndex.value - 1),
      ),
      floatingActionButton: DeleteCollectionButton(),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Obx(
            () => controller.loadingResult.value == LoadingStatus.loading
                ? LoadingIndicator.listLoading()
                : SmartRefresher(
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    cacheExtent: 200,
                    footer: SRLoadingState.loadMore,
                    onRefresh: () => controller.refresh(),
                    onLoading: () => controller.loadMore(),
                    child: GridView.builder(
                      itemCount: controller.collectionLength,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: Get.width / (Get.height / 1.8),
                      ),
                      itemBuilder: (context, index) {
                        final collections = controller.collections[index];
                        return controller.collections.isEmpty
                            ? EmptyBookmark()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ObxValue(
                                    (res) => Expanded(
                                      child: CollectionItem(
                                        collection: collections,
                                        onLongTap: res.value
                                            ? () {}
                                            : () {
                                                controller.selectItem(index);
                                                controller
                                                    .multipleSelectedMode();
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
          ),
        ),
      ),
    );
  }
}
