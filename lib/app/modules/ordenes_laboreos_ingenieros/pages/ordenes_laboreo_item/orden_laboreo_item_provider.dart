import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';


class OrdenLaboreoItemProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*----------------------------------------------------------------------------------------------- obtenerRecursosEA
  Future<EAResourcesResponse> obtenerRecursosEA(EAResourcesRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerRecursosEA", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });
    return EAResourcesResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- obtenerEACampania
  Future<List<ExplotacionAgropecuaria>> obtenerEACampania(EAResourcesRequest req) async {
    
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerExplotacionesAgropecuariasCampania", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });
    return List<ExplotacionAgropecuaria>.from(r.data.map((x) => ExplotacionAgropecuaria.fromJson(x)));

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

  //*----------------------------------------------------------------------------------------------- ObtenerExplotacionesAgropecuariasCampaniaEspecie
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

  //*----------------------------------------------------------------------------------------------- obtenerUADestino
  Future<List<UA>> obtenerUADestino(EAUaDestinoRequest req) async {
    
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerUADestino", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "clienteId":        req.clienteId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });
    return List<UA>.from(r.data.map((x) => UA.fromJson(x)));

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


//*----------------------------------------------------------------------------------------------- obtenerLotesPorCampaniaEA
  Future<LotesPorCampaniaEAResponse> obtenerLotesPorCampaniaEA(LotesPorCampaniaEARequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerLotesPorCampaniaEA", 
                                            data: {
                                              "gEconomicoId":     req.gEconomicoId,
                                              "empresaId":        req.empresaId,
                                              "afipCampaniaId":   req.afipCampaniaId,
                                              "clienteId":        req.clienteId,
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return LotesPorCampaniaEAResponse.fromJson(r.data);  
  }



  //*----------------------------------------------------------------------------------------------- insertarOL
  Future<bool> insertarOL(OLAbm ol) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = ol.toJson();
    await _dio.post("/usuarios/insertarOL", data: _data);
    return true;  
  }

  //*----------------------------------------------------------------------------------------------- updateOL
  Future<bool> updateOL(OLAbm ol) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = ol.toJson();
    await _dio.post("/usuarios/updateOL", data: _data);
    return true;  
  }

  //*----------------------------------------------------------------------------------------------- obtenerOLItemGenericaDetalle
  Future<OLAbm> obtenerOLAbm(OLAbmRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerOLAbm", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.gEconomicoId,
                                              "empresaId"             : req.empresaId,
                                              "olId"                  : req.olId,
                                            });

    return OLAbm.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- cerrarOL
  Future<ObtenerAsientosContablesOLResponse> showAsientosOL(OLAbm ol) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = ol.toJson();
    final d.Response r = await _dio.post("/usuarios/showAsientosOL", data: _data);
    return ObtenerAsientosContablesOLResponse.fromJson(r.data);  
  }

  //*----------------------------------------------------------------------------------------------- cerrarOL
  Future<bool> cerrarOL(OLAbm ol) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = ol.toJson();
    await _dio.post("/usuarios/cerrarOL", data: _data);
    return true;  
  }
}