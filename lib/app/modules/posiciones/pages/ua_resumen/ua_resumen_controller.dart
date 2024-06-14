

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ua_resumen_repository.dart';



class UAUsuarioResumenController extends GetxController with StateMixin<UAUsuarioResumenResponse> {

  final UAUsuarioResumenRepository _repository = Get.find<UAUsuarioResumenRepository>();

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerUAUsuarioResumen();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenContratista
  Future<UAUsuarioResumenResponse> obtenerUAUsuarioResumen() async {
    UAUsuarioResumenResponse response = UAUsuarioResumenResponse(listaUAUsuarioResumenItem: []);
    try {
      response = await _repository.obtenerUAUsuarioResumen();
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}