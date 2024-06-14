import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

class ConsolidaTambosProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<CtaCteLecheResumenDeLitrosMesResponse> obtenerResumenLitrosMesActual() async {

    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    final d.Response r = await _dio.post("/usuarios/ObtenerResumenLitrosMesActual", 
                                  data: {
                                    "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                  });

    return CtaCteLecheResumenDeLitrosMesResponse.fromJson(r.data);  
  }

}