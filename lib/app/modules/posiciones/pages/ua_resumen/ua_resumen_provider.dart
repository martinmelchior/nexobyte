
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';

class UAUsuarioResumenProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<UAUsuarioResumenResponse> obtenerUAUsuarioResumen() async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerUAUsuarioResumen", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return UAUsuarioResumenResponse.fromJson(r.data);  

  }

}