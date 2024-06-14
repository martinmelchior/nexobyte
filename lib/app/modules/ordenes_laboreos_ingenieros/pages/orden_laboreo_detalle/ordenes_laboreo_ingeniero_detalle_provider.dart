
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';

class OrdenLaboreoDetalleIngenieroProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ObtenerOrdenDeLaboreoIngenieroDetalleResponse> obtenerOrdenDeLaboreoDetalle(ObtenerOrdenDeLaboreoIngenieroDetalleRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerOrdenDeLaboreoDetalle", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.gEconomicoId,
                                              "empresaId"             : req.empresaId,
                                              "olId"                  : req.olId,
                                            });

    return ObtenerOrdenDeLaboreoIngenieroDetalleResponse.fromJson(r.data);  

  }

}