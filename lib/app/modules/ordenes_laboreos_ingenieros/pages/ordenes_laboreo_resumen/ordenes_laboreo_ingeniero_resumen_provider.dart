
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';


class OrdenesLaboreosResumenDeIngenieroProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerResumenIngeniero
  Future<OrdenesLaboreosResumenDeIngenieroResponse> obtenerResumenIngeniero() async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerOrdenesLaboreosResumenIngeniero", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });
    return OrdenesLaboreosResumenDeIngenieroResponse.fromJson(r.data);  
  }

  
}