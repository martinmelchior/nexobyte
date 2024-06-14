import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/updater/updater_provider.dart';

import 'updater_controller.dart';

class UpdaterBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => UpdaterController());
    Get.lazyPut(() => UpdaterProvider());
  }

}
