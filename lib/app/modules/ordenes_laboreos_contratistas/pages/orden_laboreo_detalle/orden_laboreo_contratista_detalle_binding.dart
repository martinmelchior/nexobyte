


import 'package:get/get.dart';

import 'orden_laboreo_contratista_controller.dart';
import 'orden_laboreo_contratista_provider.dart';
import 'orden_laboreo_contratista_repository.dart';

class OrdenLaboreoContratistaDetalleBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenLaboreoContratistaDetalleController>(() => OrdenLaboreoContratistaDetalleController());
    Get.lazyPut<OrdenLaboreoContratistaDetalleRepository>(() => OrdenLaboreoContratistaDetalleRepository());
    Get.lazyPut<OrdenLaboreoContratistaDetalleProvider>(() => OrdenLaboreoContratistaDetalleProvider());
      
  }

} 