

import 'package:get/get.dart';

import 'ctacte_granaria_consolida_especie_controller.dart';
import 'ctacte_granaria_consolida_especie_provider.dart';
import 'ctacte_granaria_consolida_especie_repository.dart';

class CtaCteGranariaConsolidaEspecieBinding implements Bindings {

  @override
  void dependencies() {

    Get.lazyPut<CtaCteGranariaConsolidaEspecieController>(() => CtaCteGranariaConsolidaEspecieController());
    Get.lazyPut<CtaCteGranariaConsolidaEspecieRepository>(() => CtaCteGranariaConsolidaEspecieRepository());
    Get.lazyPut<CtaCteGranariaConsolidaEspecieProvider>(() => CtaCteGranariaConsolidaEspecieProvider());
  
  }
}