
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';

class UAUsuarioDetalleProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<UAUsuarioDetalleResponse> obtenerUAUsuarioDetalle(UAUsuarioDetalleRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerUAUsuarioDetalle", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.uaResumenItem!.gEconomicoId,
                                              "empresaId"             : req.uaResumenItem!.empresaId,
                                              "uaId"                  : req.uaResumenItem!.uaId,
                                              "pageNro"               : req.pageNro,
                                              "pageSize"              : req.pageSize,
                                            });

    return UAUsuarioDetalleResponse.fromJson(r.data);  

  }

}