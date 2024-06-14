
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'ctacte_resumen_cliente_vendedor_provider.dart';


class CtaCteResumenDeSaldosClientesVendedorRepository {

  CtaCteResumenDeSaldosClientesVendedorProvider apiProvider = Get.find<CtaCteResumenDeSaldosClientesVendedorProvider>();

  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCCClientesVendedor() async {
    return apiProvider.obtenerResumenDeSaldosCCClientesVendedor();
  }

}


