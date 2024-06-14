

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'consolida_tambos_home_provider.dart';

class ConsolidaTambosRepository {

  final ConsolidaTambosProvider apiProvider = Get.find<ConsolidaTambosProvider>();

  Future<CtaCteLecheResumenDeLitrosMesResponse> obtenerResumenLitrosMesActual() async {
    return apiProvider.obtenerResumenLitrosMesActual();
  }

  
}

