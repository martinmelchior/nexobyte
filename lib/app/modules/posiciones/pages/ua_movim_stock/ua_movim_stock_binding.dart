


import 'package:get/get.dart';

import 'ua_movim_stock_controller.dart';
import 'ua_movim_stock_provider.dart';
import 'ua_movim_stock_repository.dart';

class UAMovimientoStockBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<UAMovimientoStockController>(() => UAMovimientoStockController());
    Get.lazyPut<UAMovimientoStockRepository>(() => UAMovimientoStockRepository());
    Get.lazyPut<UAMovimientoStockProvider>(() => UAMovimientoStockProvider());
      
  }

} 