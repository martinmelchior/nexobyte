

import 'package:get/get.dart';
import 'password_change_controller.dart';
import 'password_change_provider.dart';
import 'password_change_repository.dart';

class PasswordChangeBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => PasswordChangeProvider());
    Get.lazyPut(() => PasswordChangeRepository());
    Get.lazyPut(() => PasswordChangeController());
  }

}