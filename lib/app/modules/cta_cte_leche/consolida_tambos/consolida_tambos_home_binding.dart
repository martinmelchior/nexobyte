

import 'package:get/get.dart';

import 'consolida_tambos_home_controller.dart';
import 'consolida_tambos_home_provider.dart';
import 'consolida_tambos_home_repository.dart';

class CtaCteGranariaConsolidaEspecieBinding implements Bindings {

  @override
  void dependencies() {

    Get.lazyPut<ConsolidaTambosController>(() => ConsolidaTambosController());
    Get.lazyPut<ConsolidaTambosRepository>(() => ConsolidaTambosRepository());
    Get.lazyPut<ConsolidaTambosProvider>(() => ConsolidaTambosProvider());
  
  }
}