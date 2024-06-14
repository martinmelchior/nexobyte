import 'package:get/get.dart';
import 'comp_pendientes_reporte_controller.dart';
import 'comp_pendientes_reporte_provider.dart';

class CompPendientesReporteBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CompPendientesReporteController>(() => CompPendientesReporteController());
    Get.lazyPut<CompPendientesReporteProvider>(() => CompPendientesReporteProvider());
  }

}