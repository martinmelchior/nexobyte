


import 'package:get/get.dart';

import 'ordenes_laboreo_ingeniero_detalle_controller.dart';
import 'ordenes_laboreo_ingeniero_detalle_provider.dart';

class OrdenLaboreoDetalleIngenieroBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenLaboreoDetalleIngenieroController>(() => OrdenLaboreoDetalleIngenieroController());
    Get.lazyPut<OrdenLaboreoDetalleIngenieroProvider>(() => OrdenLaboreoDetalleIngenieroProvider());
      
  }

} 