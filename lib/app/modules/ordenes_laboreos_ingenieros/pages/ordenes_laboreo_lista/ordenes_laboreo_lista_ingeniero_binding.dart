


import 'package:get/get.dart';
import 'ordenes_laboreo_lista_ingeniero_controller.dart';
import 'ordenes_laboreo_lista_ingeniero_provider.dart';

class OrdenesLaboreoListaIngenieroBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenesLaboreoListaIngenieroController>(() => OrdenesLaboreoListaIngenieroController());
    Get.lazyPut<OrdenesLaboreoListaIngenieroProvider>(() => OrdenesLaboreoListaIngenieroProvider());
      
  }

} 