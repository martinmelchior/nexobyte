
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/lluvias/model/lluvias_model.dart';


class LluviasListProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerMovimientosInternos
  Future<LluviasResponse> obtenerLluvias(LluviasRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                    "gEconomicoId":     req.gEconomicoId,
                                    "empresaId":        req.empresaId,
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                  };

    final d.Response r = await _dio.post("/usuarios/obtenerLluvias", data: _data);

    return LluviasResponse.fromJson(r.data);  
  }

  //*------------------------------------------------------------------------------------------ anularMovimientoInterno
  Future<bool> eliminarLluvias(EliminarLluviaRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                    "gEconomicoId":     req.gEconomicoId,
                                    "empresaId":        req.empresaId,
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "lluvia":           req.lluvia,
                                  };

    final d.Response r = await _dio.post("/usuarios/eliminarLluvia", data: _data);

    return r.data;  
  }
  
}