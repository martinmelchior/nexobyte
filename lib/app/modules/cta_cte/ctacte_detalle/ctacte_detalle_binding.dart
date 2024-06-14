


import 'package:get/get.dart';

import 'ctacte_detalle_controller.dart';
import 'ctacte_detalle_provider.dart';
import 'ctacte_detalle_repository.dart';

class CtaCteDetalleBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CtaCteDetalleController>(() => CtaCteDetalleController());
    Get.lazyPut<CtaCteDetalleRepository>(() => CtaCteDetalleRepository());
    Get.lazyPut<CtaCteDetalleProvider>(() => CtaCteDetalleProvider());
      
  }

} 