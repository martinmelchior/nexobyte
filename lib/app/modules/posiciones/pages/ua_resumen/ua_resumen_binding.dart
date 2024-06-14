
import 'package:get/get.dart';
import 'ua_resumen_controller.dart';
import 'ua_resumen_provider.dart';
import 'ua_resumen_repository.dart';

class UAUsuarioResumenBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<UAUsuarioResumenController>(() => UAUsuarioResumenController());
    Get.lazyPut<UAUsuarioResumenRepository>(() => UAUsuarioResumenRepository());
    Get.lazyPut<UAUsuarioResumenProvider>(() => UAUsuarioResumenProvider());
      
  }

} 