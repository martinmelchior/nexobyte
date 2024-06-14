


import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ctacte_resumen_repository.dart';

class CtaCteResumenDeSaldosController extends GetxController with StateMixin<CtaCteResumenDeSaldosResponse> {

  final CtaCteResumenDeSaldosRepository _repository = Get.find<CtaCteResumenDeSaldosRepository>();

  CtaCteResumenDeSaldosController();
 
  //-- ADD 2.2
  bool enDolares = false;

  //-- ADD 2.2
  @override
  void onInit() {
    if (Get.arguments == null)
    {
      enDolares = false;
    }
    else
    {
      enDolares = Get.arguments["enDolares"] as bool;
    } 
    super.onInit();
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    //-- ADD 2.2
    await obtenerResumenDeSaldosCC(enDolares);
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenDeSaldosCC
  //-- ADD 2.2
  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCC(bool enDolares) async {
    CtaCteResumenDeSaldosResponse response = CtaCteResumenDeSaldosResponse(listaDeSaldosDeCtasCtes: []);
    try {
      change(null, status: RxStatus.loading());
      response = await _repository.obtenerResumenDeSaldosCC(enDolares);
      if (response.listaDeSaldosDeCtasCtes.isEmpty)
      {
        change(null, status: RxStatus.empty());
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