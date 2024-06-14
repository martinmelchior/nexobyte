import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ea_resources_predictivos/ea_resources_predictivos_controller.dart';
import 'package:nexobyte/app/modules/ea_resources_predictivos/ea_resources_predictivos_provider.dart';

import 'orden_laboreo_filtros_con_controller.dart';
import 'orden_laboreo_filtros_con_provider.dart';


class OrdenLaboreoFiltrosConBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<OrdenLaboreoFiltrosConController>(() => OrdenLaboreoFiltrosConController());
    Get.lazyPut<OrdenLaboreoFiltrosConProvider>(() => OrdenLaboreoFiltrosConProvider());

    Get.lazyPut<EAResourcesPredictivosController>(() => EAResourcesPredictivosController());
    Get.lazyPut<EAResourcesPredictivosProvider>(() => EAResourcesPredictivosProvider());
  }

}