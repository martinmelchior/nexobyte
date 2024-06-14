import 'package:get/get.dart';
import 'comp_pendientes_filtro_controller.dart';

class CompPendientesFiltroBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CompPendientesFiltroController>(() => CompPendientesFiltroController());
  }

}