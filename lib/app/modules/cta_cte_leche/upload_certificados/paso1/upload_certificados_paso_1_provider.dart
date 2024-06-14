
import 'dart:io';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';

class UploadCertificadosPaso1Provider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<bool> subidasPendientes(CtaCteLecheResumenDeLitrosMesItem item) async {

    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    final d.Response r = await _dio.post("/usuarios/subidasPendientes", 
                                  data: {
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "empresaId":        item.empresaId,
                                    "clienteId":        item.clienteId,
                                    "tamboId":          item.tamboId,
                                  });

    return r.data as bool;  
  }


}