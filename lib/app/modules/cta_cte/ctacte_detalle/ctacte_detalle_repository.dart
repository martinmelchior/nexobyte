

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'ctacte_detalle_provider.dart';


class CtaCteDetalleRepository {

  CtaCteDetalleProvider apiProvider = Get.find<CtaCteDetalleProvider>();

  Future<DetalleCtaCteResponse> obtenerDetalleDeCC(DetalleCtaCteRequest detalleCtaCteRequest, bool _enDolares) async {
    return apiProvider.obtenerDetalleDeCC(detalleCtaCteRequest, _enDolares);
  }

}
