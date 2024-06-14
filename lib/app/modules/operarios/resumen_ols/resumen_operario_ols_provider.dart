
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'model/resumen_ols.dart';


class ResumenOperarioOlsProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ResumenOperarioOlsResponse> obtenerResumenOperarioOls(ResumenOperarioOlsRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerResumenOperarioOls", 
                                            data: {
                                              "tokenDeRefresco" : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"    : req.gEconomicoId,
                                              "empresaId"       : req.empresaId,
                                              "clienteId"       : req.clienteId,
                                            });

    return ResumenOperarioOlsResponse.fromJson(r.data);  

  }

}