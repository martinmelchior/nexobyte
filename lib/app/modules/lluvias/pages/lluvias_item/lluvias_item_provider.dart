import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/lluvias/model/lluvias_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

class LluviasItemProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*----------------------------------------------------------------------------------------------- obtenerEACampania
  Future<EACampaniaResponse> obtenerEACampania(EACampaniaRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerExplotacionesAgropecuariasPredictivo", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "especieId":        -1,
                                            });

    return EACampaniaResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- Guardar Lluvia
  Future<SaveLluviaResponse> guardarLluvia(SaveLluviaRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                    "gEconomicoId":     req.gEconomicoId,
                                    "empresaId":        req.empresaId,
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "lluvia":           req.lluvia,
                                    "ingenieroId":      req.ingenieroId,
                                    "contratistaId":    req.contratistaId,
                                  };

    // TODO: Rcordar que esta linea el data: _data llama al toJson de cada elemento
    final d.Response r = await _dio.post("/usuarios/guardarLluvia", data: _data);

    return SaveLluviaResponse.fromJson(r.data);  
  }

}