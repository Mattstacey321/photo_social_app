import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/collection/collection_detail_controller.dart';
import 'package:photo_social/modules/collection/widgets/collection_detail_item.dart';
import 'package:photo_social/modules/collection/widgets/delete_post_button.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/utils/nested_key.dart';
import 'package:photo_social/widgets/app_bar/custom_appBar.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:photo_social/widgets/list_view/custom_footer_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectionDetail extends StatelessWidget {
  final Map<String, dynamic> _info;
  CollectionDetail({Map<String, dynamic> info}) : _info = info;
  @override
  Widget build(BuildContext context) {
    String collectionId = _info != null ? _info["id"] : "";
    String collectionName = _info != null ? _info["name"] : "...";
    return GetBuilder<CollectionDetailController>(
      init: CollectionDetailController(collectionId: collectionId),
      assignId: true,
      id: "collection-detail",
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          childs: [
            Text(
              collectionName,
              style: AppStyles.appBarTitle,
            ),
          ],
          homeIcon: ObxValue(
            (res) => AnimatedSwitcher(
              duration: 100.milliseconds,
              child:
                  res.value ? Icon(EvaIcons.close) : Icon(EvaIcons.arrowBack),
            ),
            controller.multiSelected,
          ),
          onTapBack: controller.multiSelected.value
              ? () {
                  controller.cancelMultipleSelectedMode();
                }
              : () {
                  Get.back(id: NestedKey.collection);
                },
        ),
        floatingActionButton: DeletePostButton(),
        body: _info == null
            ? SizedBox()
            : Obx(
                () => controller.loadingResult.value == LoadingStatus.loading
                    ? LoadingIndicator.listLoading()
                    : Container(
                        height: Get.height,
                        width: Get.width,
                        child: Center(
                          child: SmartRefresher(
                            controller: controller.refreshController,
                            enablePullDown: true,
                            enablePullUp: true,
                            footer: SRLoadingState.loadMore,
                            onRefresh: () => controller.refresh(),
                            onLoading: () => controller.loadMore(),
                            child: GridView.builder(
                              padding: EdgeInsets.all(5),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: Get.width / (Get.height / 2),
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
                                          });
                              },
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
