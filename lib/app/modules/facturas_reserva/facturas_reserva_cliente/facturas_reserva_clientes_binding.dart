import 'package:get/get.dart';
import 'facturas_reserva_clientes_controller.dart';
import 'facturas_reserva_clientes_provider.dart';

class FacturasReservaClientesBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<FacturasReservaClientesController>(() => FacturasReservaClientesController());
    Get.lazyPut<FacturasReservaClientesProvider>(() => FacturasReservaClientesProvider());
  }

}