
import 'package:get/get.dart';
import 'cotizacion_monedas_controller.dart';

class CotizacionMonedaBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CotizacionMonedaController>(() => CotizacionMonedaController());
      
  }

} 