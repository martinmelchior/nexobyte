

import 'package:get/get.dart';

import 'orden_laboreo_asientos_controller.dart';

class OrdenLaboreoAsientosBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<OrdenLaboreoAsientosController>(() => OrdenLaboreoAsientosController());
  }
}