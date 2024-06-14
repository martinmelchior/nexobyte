import 'package:get/get.dart';
import 'facturas_reserva_filtro_controller.dart';

class FacturasReservaFiltroBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<FacturasReservaFiltroController>(() => FacturasReservaFiltroController());
  }

}