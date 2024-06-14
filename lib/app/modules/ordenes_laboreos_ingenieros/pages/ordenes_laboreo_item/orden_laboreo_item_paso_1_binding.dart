
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/pages/ol_generica_detalle/ol_generica_detalle_controller.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/pages/ol_generica_detalle/ol_generica_detalle_provider.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/pages/ol_generica_detalle/ol_generica_detalle_repository.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_controller.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_provider.dart';

import 'orden_laboreo_item_paso_1_controller.dart';
import 'orden_laboreo_item_paso_1_provider.dart';

class OrdenLaboreoItemPaso1Binding implements Bindings {
@override
void dependencies() {
    
    Get.lazyPut<OrdenLaboreoItemPaso1Controller>(() => OrdenLaboreoItemPaso1Controller());
    Get.lazyPut<OrdenLaboreoItemPaso1Provider>(() => OrdenLaboreoItemPaso1Provider());
    
    Get.lazyPut<OrdenLaboreoItemProvider>(() => OrdenLaboreoItemProvider());
    Get.lazyPut<MenuIngenierosController>(() => MenuIngenierosController());

    Get.lazyPut<OrdenLaboreoGenericaDetalleController>(() => OrdenLaboreoGenericaDetalleController());
    Get.lazyPut<OrdenLaboreoGenericaDetalleRepository>(() => OrdenLaboreoGenericaDetalleRepository());
    Get.lazyPut<OrdenLaboreoGenericaDetalleProvider>(() => OrdenLaboreoGenericaDetalleProvider());
  

  }
}