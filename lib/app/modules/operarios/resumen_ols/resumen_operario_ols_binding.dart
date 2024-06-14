

import 'package:get/get.dart';

import 'resumen_operario_ols_controller.dart';
import 'resumen_operario_ols_provider.dart';

class ResumenOperarioOlsBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ResumenOperarioOlsController>(() => ResumenOperarioOlsController());
    Get.lazyPut<ResumenOperarioOlsProvider>(() => ResumenOperarioOlsProvider());
  }
  
}