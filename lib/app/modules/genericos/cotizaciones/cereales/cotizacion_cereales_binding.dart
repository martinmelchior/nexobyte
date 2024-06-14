
import 'package:get/get.dart';

import 'cotizacion_cereales_controller.dart';


class CotizacionCerealesBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CotizacionCerealesController>(() => CotizacionCerealesController());
      
  }

} 