

import 'dart:io';

import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/model/leche.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

class EstadisticasProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ObtenerMOResponse> obtenerMO(ObtenerMORequest req) async {

    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    final d.Response r = await _dio.post("/usuarios/ObtenerMO", 
                                  data: {
                                    "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "empresaId": req.empresaId,
                                    "clienteId": req.clienteId,
                                    "clienteTamboId": req.clienteTamboId,
                                    "fechaConsulta": req.fechaConsulta.toIso8601String(),
                                    "top": req.top,
                                    "expresionSort": "FECHA ASC"
                                  });

    return ObtenerMOResponse.fromJson(r.data);  
  }

  Future<DetalleEntregasLecheResponse> obtenerTopEntregasDeLeche(DetalleEntregasLecheRequest request) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    Map<String, dynamic> parametros = {
                                "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                "empresaId":        request.empresaId,
                                "clienteId":        request.clienteId,
                                "clienteTamboId":   request.clienteTamboId,
                                "top":              request.top,
                              };

    final d.Response r = await _dio.post("/usuarios/ObtenerUltimasEntregasLecheTambo", data: parametros);

    return DetalleEntregasLecheResponse.fromJson(r.data);  

  }

}