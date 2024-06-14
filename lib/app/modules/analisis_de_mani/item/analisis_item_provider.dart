import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import '../model/analisis_de_mani_model.dart';


class AnalisisItemProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<AnalisisDeMani> obtenerAnalisisDeManiItem(String gEconomicoId, String empresaId,int analisisId) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerAnalisisDeManiItem", 
                                            data: {
                                              "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "analisisId"        : analisisId,
                                              "gEconomicoId"      : gEconomicoId,
                                              "empresaId"         : empresaId,
                                            });

    return AnalisisDeMani.fromJson(r.data);  

  }

}