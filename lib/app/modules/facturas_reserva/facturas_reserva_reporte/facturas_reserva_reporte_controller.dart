import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';

import '../model/factura_reserva_model.dart';
import 'facturas_reserva_reporte_provider.dart';


class FacturasReservaReporteController extends GetxController with StateMixin<ApiComprobantesPendientesAplicacionResponse> {

  final FacturasReservaReporteProvider provider = Get.find<FacturasReservaReporteProvider>();
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
    EstadisticasDeUso.send("VIEW Reporte de Art.Pendiente Remitar");
    await obtenerComprobantesPendientesAplicacion();
    super.onReady();
  }

  //*----------------------------------------------------------------------------- obtenerReporteComprobantesPendientes
  Future<ApiComprobantesPendientesAplicacionResponse> obtenerComprobantesPendientesAplicacion() async {
    ApiComprobantesPendientesAplicacionResponse response = ApiComprobantesPendientesAplicacionResponse(listaDeArticulos: []);
    try {
      change(null, status: RxStatus.loading());
      response = await provider.obtenerComprobantesPendientesAplicacion(itemResumenCtaCte);
      if (response.listaDeArticulos.isEmpty)
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