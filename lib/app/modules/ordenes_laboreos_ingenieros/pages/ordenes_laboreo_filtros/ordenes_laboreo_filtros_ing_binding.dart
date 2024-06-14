import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ea_resources_predictivos/ea_resources_predictivos_controller.dart';
import 'package:nexobyte/app/modules/ea_resources_predictivos/ea_resources_predictivos_provider.dart';

import 'ordenes_laboreo_filtros_ing_controller.dart';
import 'ordenes_laboreo_filtros_ing_provider.dart';

class OrdenesLaboreoFiltrosIngBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<OrdenesLaboreoFiltrosIngController>(() => OrdenesLaboreoFiltrosIngController());
    Get.lazyPut<OrdenesLaboreoFiltrosIngProvider>(() => OrdenesLaboreoFiltrosIngProvider());

    Get.lazyPut<EAResourcesPredictivosController>(() => EAResourcesPredictivosController());
    Get.lazyPut<EAResourcesPredictivosProvider>(() => EAResourcesPredictivosProvider());
  }

}