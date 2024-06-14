

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/modules/operarios/resumen_ols/model/resumen_ols.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'resumen_operario_ols_provider.dart';

class ResumenOperarioOlsController extends GetxController with StateMixin<ResumenOperarioOlsResponse> {
  
  ResumenOperarioOlsController();
  final ResumenOperarioOlsProvider apiProvider = Get.find<ResumenOperarioOlsProvider>();
  ResumenOperarioOlsResponse response = ResumenOperarioOlsResponse();
  late CtaCteResumenDeSaldosItem parametros;
  String lastCampania = '';

  // * ----------------------------------------------------------------------------- onINit
  @override
  void onInit() {
    parametros = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;  // * lo recibo como parametro
    super.onInit();
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerResumenOperarioOls();
    super.onReady();
  }

 
  // * ----------------------------------------------------------------------------- obtenerResumenOperarioOl
  Future<ResumenOperarioOlsResponse> obtenerResumenOperarioOls() async {
    try {
      ResumenOperarioOlsRequest req = ResumenOperarioOlsRequest(
        gEconomicoId: parametros.gEconomicoId,
        empresaId: parametros.empresaId, 
        clienteId: parametros.clienteId,
      );
      change(null, status: RxStatus.loading());
      response = await apiProvider.obtenerResumenOperarioOls(req);
      change(response, status: response.listaDeItems.isEmpty ? RxStatus.empty() : RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }
}