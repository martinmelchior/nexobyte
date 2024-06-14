

import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';




class MenuContratistaProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerRecursosEA
  Future<EAResourcesResponse> obtenerRecursosEA(EAResourcesRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/ObtenerRecursosEA", 
                                            data: {
                                              "gEconomicoId": req.gEconomicoId,
                                              "empresaId": req.empresaId,
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });
    return EAResourcesResponse.fromJson(r.data);  
  }

}