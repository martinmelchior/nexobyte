

import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class CtaCteResumenDeSaldosClientesVendedorProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCCClientesVendedor() async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerResumenDeSaldosCC_ClientesVendedor", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return CtaCteResumenDeSaldosResponse.fromJson(r.data);  

  }

}