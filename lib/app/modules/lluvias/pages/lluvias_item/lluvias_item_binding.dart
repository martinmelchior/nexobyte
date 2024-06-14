

import 'package:get/get.dart';

import 'lluvias_item_controller.dart';
import 'lluvias_item_provider.dart';

class LluviasItemBinding implements Bindings {

  @override
  void dependencies() {
      Get.lazyPut<LluviasItemController>(() => LluviasItemController());
      Get.lazyPut<LluviasItemProvider>(() => LluviasItemProvider());
    }

}