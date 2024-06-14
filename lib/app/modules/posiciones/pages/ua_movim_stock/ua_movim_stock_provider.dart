
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';

class UAMovimientoStockProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<UAMovimientoStockResponse> obtenerUAMovimientosStock(UAMovimientoStockRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerUAMovimientosStock", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.uaUsuarioResumenItemMovStock!.gEconomicoId,
                                              "empresaId"             : req.uaUsuarioResumenItemMovStock!.empresaId,
                                              "uaId"                  : req.uaUsuarioResumenItemMovStock!.uaId,
                                              "articuloId"            : req.uaUsuarioResumenItemMovStock!.articuloId,
                                              "pageNro"               : req.pageNro,
                                              "pageSize"              : req.pageSize,
                                            });

    return UAMovimientoStockResponse.fromJson(r.data);  

  }

}