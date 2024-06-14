import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'remitos_sin_factura_clientes_provider.dart';

class RemitosSinFacturaFiltroClientesController extends GetxController with StateMixin<CtaCteResumenDeSaldosResponse> {

  final RemitosSinFacturaFiltroClientesProvider provider = Get.find<RemitosSinFacturaFiltroClientesProvider>();

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    //-- ADD 2.2
    EstadisticasDeUso.send("Consulta Art. Pendientes de Remitar");
    await obtenerResumenDeSaldosCC();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenDeSaldosCC
  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCC() async {
    CtaCteResumenDeSaldosResponse response = CtaCteResumenDeSaldosResponse(listaDeSaldosDeCtasCtes: []);
    try {
      response = await provider.obtenerResumenDeSaldosCC();
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