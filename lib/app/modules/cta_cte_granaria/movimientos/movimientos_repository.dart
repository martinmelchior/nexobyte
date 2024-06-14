



import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';

import 'movimientos_provider.dart';

class MovimientosRepository {

  final MovimientosProvider apiProvider = Get.find<MovimientosProvider>();

  Future<DetalleCtaCteGranariaResponse> obtenerDetalleDeCCG(DetalleCtaCteGranariaRequest request) async {
    return apiProvider.obtenerDetalleDeCCG(request);
  }

  
}