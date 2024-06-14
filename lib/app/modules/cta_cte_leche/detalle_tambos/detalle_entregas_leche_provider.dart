
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';



class DetalleEntregasLecheProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<DetalleEntregasLecheResponse> obtenerEntregasDeLeche(DetalleEntregasLecheRequest request) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    Map<String, dynamic> parametros = {
                                "empresaId":        request.empresaId,
                                "clienteId":        request.clienteId,
                                "clienteTamboId":   request.clienteTamboId,
                                "tokenDeRefresco":  request.tokenDeRefresco,
                                "fechaConsulta":    request.fechaConsulta.toIso8601String(),
                              };


    final d.Response r = await _dio.post("/usuarios/ObtenerEntregasDeLeche", data: parametros);

    

    return DetalleEntregasLecheResponse.fromJson(r.data);  

  }

}

