import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import '../models/remitos_sin_factura_model.dart';


class RemitosSinFacturaListaProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse> obtenerComprobantesPendientesAplicacion(CtaCteResumenDeSaldosItem itemResumenCtaCte) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerRemitosSinFactura", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "itemResumenCtaCte": itemResumenCtaCte,
                                            });

    return ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse.fromJson(r.data);  

  }

}