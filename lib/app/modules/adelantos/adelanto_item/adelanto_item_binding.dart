import 'package:nexobyte/app/modules/adelantos/adelanto_item/adelanto_item_provider.dart';
import 'package:get/get.dart';

import 'adelanto_item_controller.dart';

class AdelantoItemBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AdelantoItemController>(() => AdelantoItemController());
    Get.lazyPut<AdelantoItemProvider>(() => AdelantoItemProvider());
  }

}