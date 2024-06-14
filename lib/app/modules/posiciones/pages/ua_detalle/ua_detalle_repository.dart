

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'ua_detalle_provider.dart';


class UAUsuarioDetalleRepository {

  UAUsuarioDetalleProvider apiProvider = Get.find<UAUsuarioDetalleProvider>();

  Future<UAUsuarioDetalleResponse> obtenerUAUsuarioDetalle(UAUsuarioDetalleRequest request) async {
    return apiProvider.obtenerUAUsuarioDetalle(request);
  }

}