import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';


class FacturasReservaFiltroController extends GetxController with StateMixin<CtaCteResumenDeSaldosResponse> {

  Rx<bool> isSearch = true.obs;

    
  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    if (PreferenciasDeUsuarioStorage.verTodasLasCCEnComprobantesPendientes == false)
    {
      //*-- Es un cliente, redirecciono a pagina donde se ven solo sus cuentas para que elija una !
      Get.offNamed(AppRoutes.rFacturaReservaClientes);
    }
    super.onReady();
  }

}