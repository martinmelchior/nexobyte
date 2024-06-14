
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/model/ol_generica_model.dart';


class OrdenLaboreoGenericaDetalleProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<OLGenericaDetalleResponse> obtenerOLGenericaDetalle(OLGenericaDetalleRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerOrdenDeLaboreoDetalle", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.gEconomicoId,
                                              "empresaId"             : req.empresaId,
                                              "olId"                  : req.olId,
                                              //!-- Add 2.6
                                              "operarioClienteId"     : req.operarioClienteId,
                                            });

    return OLGenericaDetalleResponse.fromJson(r.data);  

  }

}