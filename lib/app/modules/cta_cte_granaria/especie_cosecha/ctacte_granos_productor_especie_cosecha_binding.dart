

import 'package:get/get.dart';
import 'ctacte_granos_productor_especie_cosecha_controller.dart';
import 'ctacte_granos_productor_especie_cosecha_provider.dart';
import 'ctacte_granos_productor_especie_cosecha_repository.dart';

class CtaCteProductorEspecieCosechaBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CtaCteProductorEspecieCosechaController>(() => CtaCteProductorEspecieCosechaController());
    Get.lazyPut<CtaCteProductorEspecieCosechaRepository>(() => CtaCteProductorEspecieCosechaRepository());
    Get.lazyPut<CtaCteProductorEspecieCosechaProvider>(() => CtaCteProductorEspecieCosechaProvider());
      
  }

} 
  