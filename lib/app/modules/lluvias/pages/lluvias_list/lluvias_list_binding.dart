

import 'package:get/get.dart';
import 'lluvias_list_controller.dart';
import 'lluvias_list_provider.dart';

class LluviasListBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LluviasListController>(() => LluviasListController());
    Get.lazyPut<LluviasListProvider>(() => LluviasListProvider());
  }
}