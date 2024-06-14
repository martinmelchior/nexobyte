import 'package:get/get.dart';

import 'redirect_controller.dart';

class RedirectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RedirectController());
  }
}