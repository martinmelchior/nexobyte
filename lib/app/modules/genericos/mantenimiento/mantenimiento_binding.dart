import 'package:get/get.dart';

import 'mantenimiento_controller.dart';

class MantenimientoBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MantenimientoController>(() => MantenimientoController());
  }
}