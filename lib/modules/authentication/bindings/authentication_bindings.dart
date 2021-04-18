import 'package:get/get.dart';

import '../../../data/api/graphql.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../sign_in/controllers/signin_controller.dart';
import '../../sign_up/controllers/signup_controller.dart';
import '../controllers/auth_controller.dart';

class AuthenticationBindings extends Bindings {
  @override
  void dependencies() {
    final selectedClient = Get.find<GraphQL>().authClient;
    Get.put(AuthRepository(authClient: selectedClient, localAuthentication: Get.find()));
    Get.put(AuthController());
    Get.lazyPut(
        () => SignInController(authRepository: Get.find(), localAuthentication: Get.find()));
    Get.lazyPut(() => SignUpController(authRepository: Get.find()));
  }
}
