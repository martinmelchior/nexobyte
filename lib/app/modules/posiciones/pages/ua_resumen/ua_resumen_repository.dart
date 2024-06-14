

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'ua_resumen_provider.dart';

class UAUsuarioResumenRepository {

  UAUsuarioResumenProvider apiProvider = Get.find<UAUsuarioResumenProvider>();

  Future<UAUsuarioResumenResponse> obtenerUAUsuarioResumen() async {
    return apiProvider.obtenerUAUsuarioResumen();
  }

}