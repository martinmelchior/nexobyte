
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import '../model/analisis_de_mani_model.dart';


class AnalisisDeManiResumenProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ResumenAnalisisItemResponse> obtenerResumenDeAnalisis() async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerResumenDeAnalisis", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return ResumenAnalisisItemResponse.fromJson(r.data);  

  }

}