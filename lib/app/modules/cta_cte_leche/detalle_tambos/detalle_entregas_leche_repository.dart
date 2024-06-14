import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';

import 'detalle_entregas_leche_provider.dart';

class DetalleEntregasLecheRepository {

  final DetalleEntregasLecheProvider apiProvider = Get.find<DetalleEntregasLecheProvider>();

  Future<DetalleEntregasLecheResponse> obtenerEntregasDeLeche(DetalleEntregasLecheRequest request) async {
     return apiProvider.obtenerEntregasDeLeche(request);
  }

  
}