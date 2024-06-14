import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ordenes_laboreo_remitar_provider.dart';


class OrdenesLaboreoRemitarController extends GetxController {

  OrdenesLaboreoRemitarController();

  final OrdenesLaboreoRemitarProvider _provider = Get.find<OrdenesLaboreoRemitarProvider>();
  final FormMode mode = FormMode.none;

  OLIngenieroItem ol = Get.arguments["ordenLaboreo"] as OLIngenieroItem;
  EAResourcesResponse recursosEA = Get.arguments["recursosEA"] as EAResourcesResponse;
  
  //*-- SIN SELECCION
  Transportista transportistaSinSeleccion = Transportista(clienteId: -1, nombre: '');
  CamionChofer camionSinSeleccion = CamionChofer(clienteCamionId: -1, chofer: '', chasisDominio: '', acopladoDominio: '');
  Chofer choferSinSeleccion = Chofer(clienteId: -1, nombre: '');

  //*-- SELECCIONADOS
  Transportista transportistaSeleccionado = Transportista();
  
  Rx<Entidad> entidad = Entidad().obs;

  // * ----------------------------------------------------------------------------- onInit
  @override
  void onInit()  {
    entidad.value.camion = camionSinSeleccion;
    entidad.value.chofer = choferSinSeleccion;
    super.onInit();
  }


  //*----------------------------------------------------------------------------------- Transportista
  int getTransportistaId() {
    int returnValue = -1;
    if (transportistaSeleccionado.clienteId != null) { returnValue = transportistaSeleccionado.clienteId!; }
    return returnValue;
  }
  Transportista getTransportista() {
    Transportista returnValue = transportistaSinSeleccion;
    if (transportistaSeleccionado.clienteId != null) { returnValue = transportistaSeleccionado; }
    return returnValue;
  }
  void setTransportista(Transportista t)  {
    if (transportistaSeleccionado.clienteId != t.clienteId) 
    { 
      transportistaSeleccionado = t;
      entidad.value.camion = camionSinSeleccion;
      entidad.refresh();
    }
  }

  //*----------------------------------------------------------------------------------- Camion
  void setCamion(CamionChofer c)  {
    entidad.value.camion = c;
    entidad.refresh();
  }

  //*----------------------------------------------------------------------------------- Chofer
  void setChofer(Chofer c)  {
    entidad.value.chofer = c;
    entidad.refresh();
  }

  //*----------------------------------------------------------------------------------- obtenerCamionesChoferes
  Future<List<CamionChofer>> obtenerCamionesChoferes(String gEconomicoId, String empresaId, int transportistaClienteId) async {
    List<CamionChofer> cc = [];
    try {
      cc = await _provider.obtenerCamionesChoferes(
                                RequestCamionChofer(
                                  gEconomicoId: gEconomicoId,
                                  empresaId: empresaId,
                                  transportistaClienteId: transportistaClienteId
                                )
                              );
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return cc;
  }

  //*----------------------------------------------------------------------------------- obtenerChoferes
  Future<List<Chofer>> obtenerChoferes(String gEconomicoId, String empresaId, int transportistaClienteId) async {
    List<Chofer> cc = [];
    try {
      cc = await _provider.obtenerChoferes(
                                RequestCamionChofer(
                                  gEconomicoId: gEconomicoId,
                                  empresaId: empresaId,
                                  transportistaClienteId: transportistaClienteId
                                )
                              );
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return cc;
  }
}

class Entidad {
  CamionChofer? camion;
  Chofer? chofer;
  
  Entidad({
    this.camion,
    this.chofer,
  });
}
