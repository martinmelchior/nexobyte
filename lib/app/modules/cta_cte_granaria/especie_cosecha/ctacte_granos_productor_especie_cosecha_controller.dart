

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';

import 'ctacte_granos_productor_especie_cosecha_repository.dart';

class CtaCteProductorEspecieCosechaController extends GetxController with StateMixin<CtaCteProductorEspecieCosechaResponse> {

  final CtaCteProductorEspecieCosechaRepository _repository = Get.find<CtaCteProductorEspecieCosechaRepository>();

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerSaldosProductorEspecieCosecha();
    EstadisticasDeUso.send("Ver Lista de Ctas Ctes Granarias");
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerSaldosProductorEspecieCosecha
  Future<CtaCteProductorEspecieCosechaResponse> obtenerSaldosProductorEspecieCosecha() async {
    CtaCteProductorEspecieCosechaResponse response = CtaCteProductorEspecieCosechaResponse();
    try {
      change(null, status: RxStatus.loading());
      response = await _repository.obtenerSaldosProductorEspecieCosecha();
      if (response.listaDeSaldoProductorEspecieCosecha.isEmpty)
      {
        change(response, status: RxStatus.empty());
      }
      else
      {
        change(response, status: RxStatus.success());
      }
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}