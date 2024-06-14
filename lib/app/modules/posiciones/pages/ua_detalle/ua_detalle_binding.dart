


import 'package:get/get.dart';

import 'ua_detalle_controller.dart';
import 'ua_detalle_provider.dart';
import 'ua_detalle_repository.dart';

class UAUsuarioDetalleBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<UAUsuarioDetalleController>(() => UAUsuarioDetalleController());
    Get.lazyPut<UAUsuarioDetalleRepository>(() => UAUsuarioDetalleRepository());
    Get.lazyPut<UAUsuarioDetalleProvider>(() => UAUsuarioDetalleProvider());
      
  }

} 