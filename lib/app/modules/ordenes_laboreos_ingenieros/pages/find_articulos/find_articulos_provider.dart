
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import '../../model/articulos_model.dart';


class FindArticulosProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<FindArticulosResponse> obtenerArticulosOL(FindArticulosRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerArticulosOL", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.gEconomicoId,
                                              "empresaId"             : req.empresaId,
                                              "pageNro"               : req.pageNro,
                                              "pageSize"              : req.pageSize,
                                              "precioDolar"           : req.precioDolar,
                                              "uaOrigenId"            : req.uaOrigenId,
                                              "findArticulo"          : req.findArticulo,
                                            });

    return FindArticulosResponse.fromJson(r.data);  

  }

}