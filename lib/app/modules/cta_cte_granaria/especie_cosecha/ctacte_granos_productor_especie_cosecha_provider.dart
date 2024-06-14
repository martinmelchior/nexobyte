

import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class CtaCteProductorEspecieCosechaProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<CtaCteProductorEspecieCosechaResponse> obtenerSaldosProductorEspecieCosecha() async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerSaldosProductorEspecieCosecha", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return CtaCteProductorEspecieCosechaResponse.fromJson(r.data);  

  }

}