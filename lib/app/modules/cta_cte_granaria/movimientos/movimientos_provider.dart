

import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class MovimientosProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<DetalleCtaCteGranariaResponse> obtenerDetalleDeCCG(DetalleCtaCteGranariaRequest request) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerDetalleDeCCG", 
                                            data: {
                                              "tokenDeRefresco":  request.tokenDeRefresco,
                                              "empresaId":        request.empresaId,
                                              "clienteId":        request.clienteId,
                                              "especieId":        request.especieId,
                                              "cosecha":          request.cosecha,
                                              "pageNro":          request.pageNro,
                                              "pageSize":         request.pageSize,
                                              "ultimoSaldo":      request.ultimoSaldo,
                                            });

    return DetalleCtaCteGranariaResponse.fromJson(r.data);  

  }

}