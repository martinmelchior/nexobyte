import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import '../model/analisis_de_mani_model.dart';


class AnalisisListaProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ObtenerAnalisisDeManiListaResponse> obtenerAnalisisDeManiLista(ResumenAnalisisItem req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerAnalisisDeManiLista", 
                                            data: {
                                              "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"      : req.gEconomicoId,
                                              "empresaId"         : req.empresaId,
                                              "empresa"           : req.empresa,
                                              "clienteId"         : req.clienteId,
                                              "clienteProductor"  : req.clienteProductor,
                                              "pageNro"           : req.pageNro,
                                              "pageSize"          : req.pageSize,
                                            });

    return ObtenerAnalisisDeManiListaResponse.fromJson(r.data);  

  }

}