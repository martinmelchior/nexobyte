
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import 'models/liquidaciones_model.dart';


class LiquidacionesListaProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerLiquidacionesLeche
  Future<LiquidacionLecheResponse> obtenerLiquidacionesLeche(CtaCteLecheResumenDeLitrosMesItem req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = {
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "clienteId":        req.clienteId,
                                    "clienteTamboId":   req.tamboId
                                  };

    final d.Response r = await _dio.post("/usuarios/obtenerLiquidacionesLeche", data: _data);

    return LiquidacionLecheResponse.fromJson(r.data);  
  }

  
  
}