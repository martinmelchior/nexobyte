

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'orden_laboreo_contratista_repository.dart';

class OrdenLaboreoContratistaDetalleController extends GetxController with StateMixin<ObtenerOrdenDeLaboreoContratistaDetalleResponse> {

  final OrdenLaboreoContratistaDetalleRepository _repository = Get.find<OrdenLaboreoContratistaDetalleRepository>();

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final param = Get.arguments as OLItemContratista;

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());

    ObtenerOrdenDeLaboreoContratistaDetalleRequest req = ObtenerOrdenDeLaboreoContratistaDetalleRequest(
      gEconomicoId: param.gEconomicoId,
      empresaId: param.empresaId,
      olId: param.olId,
      tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco
    );
    
    await obtenerOrdenDeLaboreoDetalle(req);
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenContratista
  Future<ObtenerOrdenDeLaboreoContratistaDetalleResponse> obtenerOrdenDeLaboreoDetalle(ObtenerOrdenDeLaboreoContratistaDetalleRequest req) async {

    ObtenerOrdenDeLaboreoContratistaDetalleResponse response = ObtenerOrdenDeLaboreoContratistaDetalleResponse();
    
    try {
      response = await _repository.obtenerOrdenDeLaboreoDetalle(req);
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }

    return response;
  }

  
}