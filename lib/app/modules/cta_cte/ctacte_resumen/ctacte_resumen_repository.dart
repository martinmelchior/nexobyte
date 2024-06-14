
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'ctacte_resumen_provider.dart';


class CtaCteResumenDeSaldosRepository {

  CtaCteResumenDeSaldosProvider apiProvider = Get.find<CtaCteResumenDeSaldosProvider>();

  //-- ADD 2.2
  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCC(bool enDolares) async {
    return apiProvider.obtenerResumenDeSaldosCC(enDolares);
  }

}


