import 'package:get/get.dart';
import 'facturas_reserva_reporte_controller.dart';
import 'facturas_reserva_reporte_provider.dart';

class FacturasReservaReporteBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<FacturasReservaReporteController>(() => FacturasReservaReporteController());
    Get.lazyPut<FacturasReservaReporteProvider>(() => FacturasReservaReporteProvider());
  }

}