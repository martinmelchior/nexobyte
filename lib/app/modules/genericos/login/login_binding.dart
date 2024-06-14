

import 'package:get/get.dart';
import 'login_controller.dart';
import 'login_provider.dart';
import 'login_repository.dart';

class LoginBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<LoginRepository>(() => LoginRepository());
    Get.lazyPut<LoginProvider>(() => LoginProvider());
  }

}