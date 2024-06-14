
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'ctacte_granos_productor_especie_cosecha_provider.dart';


class CtaCteProductorEspecieCosechaRepository {

  CtaCteProductorEspecieCosechaProvider apiProvider = Get.find<CtaCteProductorEspecieCosechaProvider>();

  Future<CtaCteProductorEspecieCosechaResponse> obtenerSaldosProductorEspecieCosecha() async {
    return apiProvider.obtenerSaldosProductorEspecieCosecha();
  }

}


