import 'package:get/get.dart';

import 'app_version_info_controller.dart';

class AppVersionInfoBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AppVersionInfoController>(() => AppVersionInfoController());
  }
}