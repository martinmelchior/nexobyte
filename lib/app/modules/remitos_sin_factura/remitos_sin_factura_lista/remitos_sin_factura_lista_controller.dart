import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';

import '../models/remitos_sin_factura_model.dart';
import 'remitos_sin_factura_lista_provider.dart';


class RemitosSinFacturaListaController extends GetxController with StateMixin<ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse> {

  final RemitosSinFacturaListaProvider provider = Get.find<RemitosSinFacturaListaProvider>();
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
    EstadisticasDeUso.send("VIEW Reporte de Remitos Sin Facturar");
    await obtenerComprobantesPendientesAplicacion();
    super.onReady();
  }

  //*----------------------------------------------------------------------------- obtenerReporteComprobantesPendientes
  Future<ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse> obtenerComprobantesPendientesAplicacion() async {
    ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse response = ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse(
      saldo: 0.0,
      listaDeSubTotal: [],
      listaDeRE: [],
      listaDeRS: [],
      listaDetallePorArticulo: [],
    );

    try {
      change(null, status: RxStatus.loading());
      response = await provider.obtenerComprobantesPendientesAplicacion(itemResumenCtaCte);
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }
}