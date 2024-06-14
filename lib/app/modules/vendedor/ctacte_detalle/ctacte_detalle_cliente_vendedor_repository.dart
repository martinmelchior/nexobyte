

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'ctacte_detalle_cliente_vendedor_provider.dart';


class CtaCteDetalleClienteVendedorRepository {

  CtaCteDetalleClienteVendedorProvider apiProvider = Get.find<CtaCteDetalleClienteVendedorProvider>();

  Future<DetalleCtaCteResponse> obtenerDetalleDeCC(DetalleCtaCteRequest detalleCtaCteRequest) async {
    return apiProvider.obtenerDetalleDeCC(detalleCtaCteRequest);
  }

}
