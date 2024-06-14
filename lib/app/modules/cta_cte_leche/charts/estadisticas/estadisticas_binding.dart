import 'package:nexobyte/app/modules/cta_cte_leche/charts/estadisticas/estadisticas_provider.dart';
import 'package:get/get.dart';

import 'estadisticas_controller.dart';

class EstadisticasBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<EstadisticasController>(() => EstadisticasController());
    Get.lazyPut<EstadisticasProvider>(() => EstadisticasProvider());
  }
  
}