import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import '../model/factura_reserva_model.dart';


class FacturasReservaReporteProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ApiComprobantesPendientesAplicacionResponse> obtenerComprobantesPendientesAplicacion(CtaCteResumenDeSaldosItem itemResumenCtaCte) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerComprobantesPendientesAplicacion", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "itemResumenCtaCte": itemResumenCtaCte,
                                            });

    return ApiComprobantesPendientesAplicacionResponse.fromJson(r.data);  

  }

}