import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class CtaCteDetalleClienteVendedorProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<DetalleCtaCteResponse> obtenerDetalleDeCC(DetalleCtaCteRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerDetalleDeCC", 
                                            data: {
                                              "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "resumenDeSaldoItem": req.ctaCteResumenDeSaldosItem,
                                              "fd"                : req.fd,
                                              "fh"                : req.fh,
                                              "pageNro"           : req.pageNro,
                                              "pageSize"          : req.pageSize,
                                              "fieldName"         : req.fieldName,
                                              "isAsc"             : req.isAsc,
                                              "ultimoSaldo"       : req.ultimoSaldo,
                                            });

    return DetalleCtaCteResponse.fromJson(r.data);  

  }

}