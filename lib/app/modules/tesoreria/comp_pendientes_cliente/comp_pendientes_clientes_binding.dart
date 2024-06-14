import 'package:get/get.dart';
import 'comp_pendientes_clientes_controller.dart';
import 'comp_pendientes_clientes_provider.dart';

class CompPendientesClientesBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CompPendientesClientesController>(() => CompPendientesClientesController());
    Get.lazyPut<CompPendientesClientesProvider>(() => CompPendientesClientesProvider());
  }

}