
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/modules/ea_resources_predictivos/ea_resources_predictivos_controller.dart';
import 'package:nexobyte/app/modules/ea_resources_predictivos/ea_resources_predictivos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';


class OrdenLaboreoFiltrosConController extends GetxController {

  OrdenLaboreoFiltrosConController();


  final EAResourcesPredictivosController controllerResources = Get.find<EAResourcesPredictivosController>();

  // * ----------------------------------------------------------------------------- traigo los filtros y los actualizo!
  final filtrosOLs = Get.arguments["filtrosOLs"] as Rx<FiltrosOLsCon>;

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final itemResumenIngeniero = Get.arguments["itemResumenContratista"] as OrdenesLaboreosResumenDeContratistasItem;
  final recursosEA = Get.arguments["recursosEA"] as EAResourcesResponse ;

  
  @override
  void onReady() {
    super.onReady();
    filtrosOLs.refresh();
  }

  // * ----------------------------------------------------------------------------------------------------------- obtenerEAPredictivo
  Future<List<ExplotacionAgropecuaria>> obtenerEAPredictivo() async {
    EAsPredictivoResponse response = EAsPredictivoResponse();
    try {

      //*-- Si selecciono la campaña la tomo como filtro, sino no!
      //*------------------------------------------------------------------
      int _afipCampaniaId = 0;
      if (filtrosOLs.value.campania != null && filtrosOLs.value.campania!.afipCampaniaId! > 0)
      {
        _afipCampaniaId = filtrosOLs.value.campania!.afipCampaniaId!;
      }

      response = await controllerResources.obtenerEAPredictivo(
        EAsPredictivoRequest(
          gEconomicoId: itemResumenIngeniero.gEconomicoId,
          empresaId: itemResumenIngeniero.empresaId,
          afipCampaniaId: _afipCampaniaId,
          especieId: 0
        ), false);
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return response.eas;
  }

  
  //*-------------------------------------------------------------------- Validacion de controles
  bool pageIsValid() {
    bool returnValue = false;
    if (filtrosOLs.value.campania != null && filtrosOLs.value.campania!.afipCampaniaId! > 0) returnValue = true;
    if (filtrosOLs.value.ea != null && filtrosOLs.value.ea!.clienteId! > 0) returnValue = true;
    if (filtrosOLs.value.especie != null && filtrosOLs.value.especie!.especieId! > 0) returnValue = true;
    if (filtrosOLs.value.laboreo != null && filtrosOLs.value.laboreo!.laboreoId! > 0) returnValue = true;
    return returnValue;
  }


  //*----------------------------------------------------------------------------------- Filtrar ESPECIE
  Future<List<Especie>> obtenerEspeciesEnCampania() async {
    List<Especie> especies = [];
    try {

      //*-- Si selecciono la campaña la tomo como filtro, sino no!
      //*------------------------------------------------------------------
      int _afipCampaniaId = 0;
      if (filtrosOLs.value.campania != null && filtrosOLs.value.campania!.afipCampaniaId! > 0)
      {
        _afipCampaniaId = filtrosOLs.value.campania!.afipCampaniaId!;
      }

      especies = await controllerResources.obtenerEspeciesEnCampania(
                                              EAEspecieEnCampaniaRequest(
                                                gEconomicoId:   itemResumenIngeniero.gEconomicoId,
                                                empresaId:      itemResumenIngeniero.empresaId,
                                                afipCampaniaId: _afipCampaniaId,
                                              ));
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return especies;
  }
}