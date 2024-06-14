

import 'package:get/get.dart';
import 'ctacte_resumen_controller.dart';
import 'ctacte_resumen_provider.dart';
import 'ctacte_resumen_repository.dart';

class CtaCteResumenDeSaldosBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CtaCteResumenDeSaldosController>(() => CtaCteResumenDeSaldosController());
    Get.lazyPut<CtaCteResumenDeSaldosRepository>(() => CtaCteResumenDeSaldosRepository());
    Get.lazyPut<CtaCteResumenDeSaldosProvider>(() => CtaCteResumenDeSaldosProvider());
      
  }

} 
  