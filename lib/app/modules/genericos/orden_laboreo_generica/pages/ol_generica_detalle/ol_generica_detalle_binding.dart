


import 'package:get/get.dart';

import 'ol_generica_detalle_controller.dart';
import 'ol_generica_detalle_provider.dart';
import 'ol_generica_detalle_repository.dart';

class OrdenLaboreoGenericaDetalleBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenLaboreoGenericaDetalleController>(() => OrdenLaboreoGenericaDetalleController());
    Get.lazyPut<OrdenLaboreoGenericaDetalleRepository>(() => OrdenLaboreoGenericaDetalleRepository());
    Get.lazyPut<OrdenLaboreoGenericaDetalleProvider>(() => OrdenLaboreoGenericaDetalleProvider());
      
  }

} 