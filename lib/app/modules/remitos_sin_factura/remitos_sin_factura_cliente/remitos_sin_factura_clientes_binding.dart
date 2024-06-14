import 'package:get/get.dart';
import 'remitos_sin_factura_clientes_controller.dart';
import 'remitos_sin_factura_clientes_provider.dart';

class RemitosSinFacturaFiltroClientesBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RemitosSinFacturaFiltroClientesController>(() => RemitosSinFacturaFiltroClientesController());
    Get.lazyPut<RemitosSinFacturaFiltroClientesProvider>(() => RemitosSinFacturaFiltroClientesProvider());
  }

}