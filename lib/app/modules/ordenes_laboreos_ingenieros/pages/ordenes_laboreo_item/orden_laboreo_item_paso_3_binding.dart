
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_controller.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_provider.dart';
import 'orden_laboreo_item_paso_1_controller.dart';
import 'orden_laboreo_item_paso_3_controller.dart';


class OrdenLaboreoItemPaso3Binding implements Bindings {
@override
void dependencies() {
    
    Get.lazyPut<OrdenLaboreoItemPaso1Controller>(() => OrdenLaboreoItemPaso1Controller());
    Get.lazyPut<OrdenLaboreoItemPaso3Controller>(() => OrdenLaboreoItemPaso3Controller());
    Get.lazyPut<OrdenLaboreoItemProvider>(() => OrdenLaboreoItemProvider());
    Get.lazyPut<MenuIngenierosController>(() => MenuIngenierosController());

  }
}