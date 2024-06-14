

import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as d;

import '../../../data/models/cta_cte_resumen_saldo.dart';
import '../model/adelantos_model.dart';


class ChequeItemProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ObtenerBancosResponse> obtenerBancos(CtaCteResumenDeSaldosItem item) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerBancos", 
                                            data: {
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId": item.gEconomicoId,
                                              "empresaId": item.empresaId,
                                              "clienteId": item.clienteId,
                                            });

    return ObtenerBancosResponse.fromJson(r.data);

  }

  

}