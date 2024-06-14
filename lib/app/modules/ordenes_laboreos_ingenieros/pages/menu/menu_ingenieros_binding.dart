

import 'package:get/get.dart';

import 'menu_ingenieros_provider.dart';
import 'menu_ingenieros_controller.dart';

class MenuIngenierosBinding implements Bindings {
  
  @override
  void dependencies() {

    Get.lazyPut<MenuIngenierosController>(() => MenuIngenierosController());
    Get.lazyPut<MenuIngenieroProvider>(() => MenuIngenieroProvider());

  }
}