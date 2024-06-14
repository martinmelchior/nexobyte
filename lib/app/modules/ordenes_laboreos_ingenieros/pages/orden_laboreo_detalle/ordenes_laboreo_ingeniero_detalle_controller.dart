

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ordenes_laboreo_ingeniero_detalle_provider.dart';



class OrdenLaboreoDetalleIngenieroController extends GetxController with StateMixin<ObtenerOrdenDeLaboreoIngenieroDetalleResponse> {

  final OrdenLaboreoDetalleIngenieroProvider _provider = Get.find<OrdenLaboreoDetalleIngenieroProvider>();
  
  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  //!-- Add Remitar OL
  final isRemitar = false.obs;
  final isCerrar = false.obs;
  final accion = Get.arguments['accion'] ?? '';
  final param = Get.arguments['ordenLaboreo'] as OLIngenieroItem;
  
  late EAResourcesResponse recursosEA;
  

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());

    if (Get.arguments['recursosEA'] != null)
    {
      recursosEA = Get.arguments['recursosEA'] as EAResourcesResponse;
    }

    ObtenerOrdenDeLaboreoIngenieroDetalleRequest req = ObtenerOrdenDeLaboreoIngenieroDetalleRequest(
      gEconomicoId: param.gEconomicoId,
      empresaId: param.empresaId,
      olId: param.olId,
      tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco
    );
    
    await obtenerOrdenDeLaboreoDetalle(req);
    //!-- Add Remitar OL
    isRemitar.value = (accion.toString().toUpperCase() == 'REMITAR');
    isCerrar.value = (accion.toString().toUpperCase() == 'CERRAR');
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenContratista
  Future<ObtenerOrdenDeLaboreoIngenieroDetalleResponse> obtenerOrdenDeLaboreoDetalle(ObtenerOrdenDeLaboreoIngenieroDetalleRequest req) async {

    ObtenerOrdenDeLaboreoIngenieroDetalleResponse response = ObtenerOrdenDeLaboreoIngenieroDetalleResponse();
    
    try {
      response = await _provider.obtenerOrdenDeLaboreoDetalle(req);
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }

    return response;
  }

  
}