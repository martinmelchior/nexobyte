import 'package:get/get.dart';
import 'remitos_sin_factura_lista_controller.dart';
import 'remitos_sin_factura_lista_provider.dart';

class RemitosSinFacturaListaBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RemitosSinFacturaListaController>(() => RemitosSinFacturaListaController());
    Get.lazyPut<RemitosSinFacturaListaProvider>(() => RemitosSinFacturaListaProvider());
  }

}