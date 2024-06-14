

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/model/ol_generica_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ol_generica_detalle_repository.dart';

class OrdenLaboreoGenericaDetalleController extends GetxController with StateMixin<OLGenericaDetalleResponse> {

  final OrdenLaboreoGenericaDetalleRepository _repository = Get.find<OrdenLaboreoGenericaDetalleRepository>();

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final req = Get.arguments as OLGenericaDetalleRequest;

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerOLGenericaDetalle(req);
    super.onReady();
  }

  // * ---------------------------------------------------------------------------------------------------- obtenerOLGenericaDetalle
  Future<OLGenericaDetalleResponse> obtenerOLGenericaDetalle(OLGenericaDetalleRequest req) async {

    OLGenericaDetalleResponse response = OLGenericaDetalleResponse();
    
    try {
      response = await _repository.obtenerOLGenericaDetalle(req);
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }

    return response;
  }


  
  
}