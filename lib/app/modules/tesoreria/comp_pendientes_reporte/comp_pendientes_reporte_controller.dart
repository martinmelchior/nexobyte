import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import '../model/tesoreria_model.dart';
import 'comp_pendientes_reporte_provider.dart';


class CompPendientesReporteController extends GetxController with StateMixin<ComprobantesPendientesResponse> {

  final CompPendientesReporteProvider provider = Get.find<CompPendientesReporteProvider>();
  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  Rx<bool> showButton = false.obs;

  //*----------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();
    itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;  // * lo recibo como parametro  
  }

  //*----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerReporteComprobantesPendientes();
    super.onReady();
  }

  //*----------------------------------------------------------------------------- obtenerReporteComprobantesPendientes
  Future<ComprobantesPendientesResponse> obtenerReporteComprobantesPendientes() async {
    ComprobantesPendientesResponse response = ComprobantesPendientesResponse(listaDeComprobantesPendientes: []);
    try {
      change(null, status: RxStatus.loading());
      response = await provider.obtenerReporteComprobantesPendientes(itemResumenCtaCte);
      if (response.listaDeComprobantesPendientes.isEmpty)
      {
        
        change(null, status: RxStatus.empty());
      }
      else
      {
        showButton.value = true;
        showButton.refresh;
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