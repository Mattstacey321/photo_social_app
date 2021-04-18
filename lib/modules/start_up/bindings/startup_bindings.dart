import 'package:get/get.dart';

import '../../../data/api/graphql.dart';
import '../../../data/repositories/start_up_repository.dart';
import '../startup_controller.dart';

class StartUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartUpRepository(pubClient: Get.find<GraphQL>().pubClient));
    Get.lazyPut(()=>StartUpController(startUpRepository: Get.find()));
  }
}
