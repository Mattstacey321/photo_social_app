import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../hash_tag/controllers/hashtag_controller.dart';
import '../../hash_tag/widgets/hashtag_item.dart';
import '../controllers/base_controller.dart';

class SideBar extends GetView<BaseController> {
  @override
  Widget build(BuildContext context) {
    var hashTagController = HashTagController.to;
    return Container(
      height: Get.height,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // main menu
          Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 20),
              child: ObxValue<RxInt>(
                (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildItem(
                        itemIndex: 0,
                        currentIndex: index.value,
                        title: "Home",
                        selectedIcon: EvaIcons.home,
                        unSelectedIcon: EvaIcons.homeOutline,
                      ),
                      _buildItem(
                        itemIndex: 1,
                        currentIndex: index.value,
                        title: "Collection",
                        selectedIcon: EvaIcons.heart,
                        unSelectedIcon: EvaIcons.heartOutline,
                      ),
                    ],
                  );
                },
                controller.currentPageIndex,
              ),
            ),
          ),
          //display hashtag
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Hash tag",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(
                      () {
                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          itemCount: hashTagController.hashTags.length,
                          itemBuilder: (_, index) {
                            final tags = hashTagController.hashTags;
                            return tags.isEmpty
                                ? Text("No hashtag found now")
                                : HashTagItem(
                                    hashTag: tags[index],
                                    onTap: () {
                                      hashTagController.selectedHashTag(index);
                                    },
                                  );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(
      {@required int itemIndex,
      @required int currentIndex,
      @required String title,
      @required IconData selectedIcon,
      @required IconData unSelectedIcon}) {
    Color iconColor = itemIndex == currentIndex ? Colors.blue : Colors.white;
    Color textColor = itemIndex == currentIndex ? Colors.blue : Colors.white;
    FontWeight fontWeight = itemIndex == currentIndex ? FontWeight.bold : FontWeight.w100;
    Color selectedColor =
        itemIndex == currentIndex ? Colors.blue.withOpacity(0.2) : Colors.transparent;
    return AnimatedContainer(
      duration: 200.milliseconds,
      height: 50,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: selectedColor,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.changePage(itemIndex);
        },
        child: Row(
          children: <Widget>[
            AnimatedSwitcher(
              duration: 200.milliseconds,
              child: itemIndex == currentIndex
                  ? Icon(selectedIcon, color: iconColor)
                  : Icon(unSelectedIcon, color: iconColor),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(fontWeight: fontWeight, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
