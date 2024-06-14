
import 'package:get/get.dart';

import 'ordenes_laboreo_ingeniero_resumen_controller.dart';
import 'ordenes_laboreo_ingeniero_resumen_provider.dart';

class OrdenesLaboreosResumenDeIngenieroBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenesLaboreosResumenDeIngenieroController>(() => OrdenesLaboreosResumenDeIngenieroController());
    Get.lazyPut<OrdenesLaboreosResumenDeIngenieroProvider>(() => OrdenesLaboreosResumenDeIngenieroProvider());
      
  }

} 