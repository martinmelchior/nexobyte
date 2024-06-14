

import 'package:get/get.dart';

import 'analisis_de_mani_resumen_controller.dart';
import 'analisis_de_mani_resumen_provider.dart';

class AnalisisDeManiResumenBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<AnalisisDeManiResumenController>(() => AnalisisDeManiResumenController());
    Get.lazyPut<AnalisisDeManiResumenProvider>(() => AnalisisDeManiResumenProvider());
      
  }

} 
  