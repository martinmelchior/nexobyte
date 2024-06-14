import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';

import 'ea_resources_predictivos_model.dart';


class EAResourcesPredictivosProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*----------------------------------------------------------------------------------------------- 
  //* otenerExplotacionesAgropecuariasPredictivo - puedo pasar especie y campaña en 0 y trae todas
  //*----------------------------------------------------------------------------------------------- 
  Future<EAsPredictivoResponse> otenerExplotacionesAgropecuariasPredictivo(EAsPredictivoRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerExplotacionesAgropecuariasPredictivo", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "especieId":        req.especieId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return EAsPredictivoResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- obtenerEspeciesPredictivo
  Future<EAEspecieEnCampaniaResponse> obtenerEspeciesPredictivo(EAEspecieEnCampaniaRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerEspeciesPredictivo", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return EAEspecieEnCampaniaResponse.fromJson(r.data);  
  }

}