

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'ua_movim_stock_provider.dart';


class UAMovimientoStockRepository {

  UAMovimientoStockProvider apiProvider = Get.find<UAMovimientoStockProvider>();

  Future<UAMovimientoStockResponse> obtenerUAMovimientosStock(UAMovimientoStockRequest request) async {
    return apiProvider.obtenerUAMovimientosStock(request);
  }

}