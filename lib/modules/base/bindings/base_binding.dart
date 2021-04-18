import 'package:get/get.dart';
import '../../../data/api/graphql.dart';
import '../../../data/repositories/bookmark_repository.dart';
import '../../../data/repositories/collection_repository.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/forum_repository.dart';
import '../../../data/repositories/hashtag_repository.dart';
import '../controllers/base_controller.dart';

import '../../bookmark/controllers/bookmark_controller.dart';
import '../../collection/controllers/collection_controller.dart';
import '../../forum/controllers/forum_controller.dart';
import '../../hash_tag/controllers/hashtag_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    final selectedClient = Get.find<GraphQL>().selectClient;
    Get.put(ProfileController(localAuth: Get.find()), permanent: true);
    Get.lazyPut(() => BaseController());
    Get.put(ForumRepository(client: selectedClient));
    Get.put(ForumController(forumRepository: Get.find()), permanent: true);
    Get.put(HomeController());
    Get.put(HashTagRepository(client: selectedClient));
    Get.put(HashTagController(hashTagRepository: Get.find()), permanent: true);
    Get.put(BookmarkRepository(client: selectedClient));
    Get.put(BookmarkController(bookmarkRepository: Get.find()), permanent: true);
    Get.put(CollectionRepository(client: selectedClient));
    Get.put(CollectionController(collectionRepository: Get.find()), permanent: true);
    Get.put(CommentRepository(client: selectedClient));
  }
}
