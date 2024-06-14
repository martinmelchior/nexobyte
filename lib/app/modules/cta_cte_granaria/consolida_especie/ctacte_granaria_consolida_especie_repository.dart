

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'ctacte_granaria_consolida_especie_provider.dart';

class CtaCteGranariaConsolidaEspecieRepository {

  final CtaCteGranariaConsolidaEspecieProvider apiProvider = Get.find<CtaCteGranariaConsolidaEspecieProvider>();

  Future<SaldosPorEspecieResponse> loadSaldosPorEspecie() async {
    return apiProvider.loadSaldosPorEspecie();
  }

  
}

