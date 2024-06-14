


import 'package:get/get.dart';

import 'ordenes_laboreo_lista_contratista_controller.dart';
import 'ordenes_laboreo_lista_contratista_provider.dart';
import 'ordenes_laboreo_lista_contratista_repository.dart';

class OrdenesLaboreoContratistaBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenesLaboreoContratistaController>(() => OrdenesLaboreoContratistaController());
    Get.lazyPut<OrdenesLaboreoContratistaRepository>(() => OrdenesLaboreoContratistaRepository());
    Get.lazyPut<OrdenesLaboreoContratistaProvider>(() => OrdenesLaboreoContratistaProvider());
      
  }

} 