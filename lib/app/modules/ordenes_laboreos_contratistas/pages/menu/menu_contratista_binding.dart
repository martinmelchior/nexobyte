

import 'package:get/get.dart';

import 'menu_contratista_provider.dart';
import 'menu_contratista_controller.dart';

class MenuContratistaBinding implements Bindings {
  
  @override
  void dependencies() {

    Get.lazyPut<MenuContratistaController>(() => MenuContratistaController());
    Get.lazyPut<MenuContratistaProvider>(() => MenuContratistaProvider());

  }
}