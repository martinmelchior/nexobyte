
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';


class MovInternoListProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerMovimientosInternos
  Future<MovimientoResponse> obtenerMovimientosInternos(MovimientoRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                    "gEconomicoId":     req.gEconomicoId,
                                    "empresaId":        req.empresaId,
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "contratistaId":    req.contratistaId,
                                    "ingenieroId":      req.ingenieroId,
                                  };

    final d.Response r = await _dio.post("/usuarios/obtenerMovimientosInternos", data: _data);

    return MovimientoResponse.fromJson(r.data);  
  }

  //*------------------------------------------------------------------------------------------ anularMovimientoInterno
  Future<MovimientoResponse> anularMovimientoInterno(MovimientoRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                    "gEconomicoId":     req.gEconomicoId,
                                    "empresaId":        req.empresaId,
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "movInterno":       req.movInterno,
                                  };

    final d.Response r = await _dio.post("/usuarios/anularMovimientoInterno", data: _data);

    return MovimientoResponse.fromJson(r.data);  
  }
  
}