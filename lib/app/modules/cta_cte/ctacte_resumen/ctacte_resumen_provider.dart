

import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class CtaCteResumenDeSaldosProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCC(bool enDolares) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    //-- ADD 2.2
    final d.Response r = await _dio.post("/usuarios/ObtenerResumenDeSaldosCC", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "enDolares": enDolares,
                                            });

    return CtaCteResumenDeSaldosResponse.fromJson(r.data);  

  }

}