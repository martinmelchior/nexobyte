

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/movimientos/movimientos_provider.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/movimientos/movimientos_repository.dart';

import 'movimientos_controller.dart';

class MovimientosBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<MovimientosController>(() => MovimientosController());
    Get.lazyPut<MovimientosRepository>(() => MovimientosRepository());
    Get.lazyPut<MovimientosProvider>(() => MovimientosProvider());
  }
  
}