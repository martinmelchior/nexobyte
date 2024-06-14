import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ea_resources_predictivos_model.dart';
import 'ea_resources_predictivos_provider.dart';

class EAResourcesPredictivosController extends GetxController  {

  final EAResourcesPredictivosProvider _provider = Get.find<EAResourcesPredictivosProvider>();

  // * ----------------------------------------------------------------------------------------------------------- obtenerEAPredictivo
  Future<EAsPredictivoResponse> obtenerEAPredictivo(EAsPredictivoRequest req, bool showDialog) async {

    EAsPredictivoResponse eas = EAsPredictivoResponse();
    if (showDialog)
    {
      Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
    }
    try {
      eas = await _provider.otenerExplotacionesAgropecuariasPredictivo(req);
      if (showDialog)
      {
        Get.back();
      }
    } 
    catch(e) {
      if (showDialog)
      {
        Get.back();
      }
      ApiExceptions.procesarError(e);
    }
    return eas;
  }



  //*----------------------------------------------------------------------------------- Filtrar ESPECIE
  Future<List<Especie>> obtenerEspeciesEnCampania(EAEspecieEnCampaniaRequest req) async {
    List<Especie> especies = [];
    try {
      EAEspecieEnCampaniaResponse result = await _provider.obtenerEspeciesPredictivo(
                                                            EAEspecieEnCampaniaRequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                            ));
      especies = result.especies;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return especies;
  }
  
}