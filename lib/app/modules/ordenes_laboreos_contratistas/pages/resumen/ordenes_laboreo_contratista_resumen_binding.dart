
import 'package:get/get.dart';
import 'ordenes_laboreo_contratista_resumen_controller.dart';
import 'ordenes_laboreo_contratista_resumen_provider.dart';
import 'ordenes_laboreo_contratista_resumen_repository.dart';

class OrdenesLaboreosResumenDeContratistaBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<OrdenesLaboreosResumenDeContratistaController>(() => OrdenesLaboreosResumenDeContratistaController());
    Get.lazyPut<OrdenesLaboreosResumenDeContratistaRepository>(() => OrdenesLaboreosResumenDeContratistaRepository());
    Get.lazyPut<OrdenesLaboreosResumenDeContratistaProvider>(() => OrdenesLaboreosResumenDeContratistaProvider());
      
  }

} 