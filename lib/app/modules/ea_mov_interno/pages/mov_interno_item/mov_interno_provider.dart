import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';


class MovInternoItemProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*----------------------------------------------------------------------------------------------- obtenerRecursosEA
  Future<EACampaniaEspecieResponse> obtenerEACampaniaEspecie(EACampaniaEspecieRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerExplotacionesAgropecuariasCampaniaEspecie", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "especieId":        req.especieId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return EACampaniaEspecieResponse.fromJson(r.data);  
  }


  //*----------------------------------------------------------------------------------------------- obtenerEspeciesEnCampania
  Future<EAEspecieEnCampaniaResponse> obtenerEspeciesEnCampania(EAEspecieEnCampaniaRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerEspeciesEnCampania", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return EAEspecieEnCampaniaResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- obtenerLotesPorCampaniaEspecieEA
  Future<LotesPorCampaniaEspecieEAResponse> obtenerLotesPorCampaniaEspecieEA(LotesPorCampaniaEspecieEARequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerLotesPorCampaniaEspecieEA", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "clienteId":        req.clienteId,
                                              "especieId":        req.especieId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return LotesPorCampaniaEspecieEAResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- obtenerLotesPorCampaniaEspecieEA
  Future<UAsPorCampaniaEspecieEAResponse> obtenerUAsPorCampaniaEspecieEA(UAsPorCampaniaEspecieEARequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerUAsPorCampaniaEspecieEA", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "clienteId":        req.clienteId,
                                              "especieId":        req.especieId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return UAsPorCampaniaEspecieEAResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- Guardar Movimiento Interno
  Future<MovimientoResponse> guardarMovimientoInterno(MovimientoRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "movInterno":       req.movInterno,
                                            };

    final d.Response r = await _dio.post("/usuarios/GuardarMovimientoInterno", data: _data);

    return MovimientoResponse.fromJson(r.data);  
  }
}