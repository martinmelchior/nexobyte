

import 'package:get/get.dart';

import 'ordenes_laboreo_remitar_controller.dart';
import 'ordenes_laboreo_remitar_provider.dart';

class OrdenesLaboreoRemitarBinding implements Bindings {

  @override
  void dependencies() {
      Get.lazyPut<OrdenesLaboreoRemitarController>(() => OrdenesLaboreoRemitarController());
      Get.lazyPut<OrdenesLaboreoRemitarProvider>(() => OrdenesLaboreoRemitarProvider());
    }

}