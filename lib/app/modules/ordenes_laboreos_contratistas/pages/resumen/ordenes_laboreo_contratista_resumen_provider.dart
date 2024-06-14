
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';

class OrdenesLaboreosResumenDeContratistaProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<OrdenesLaboreosResumenDeContratistaResponse> obtenerResumenContratista() async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerOrdenesLaboreosResumenContratista", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return OrdenesLaboreosResumenDeContratistaResponse.fromJson(r.data);  

  }

}