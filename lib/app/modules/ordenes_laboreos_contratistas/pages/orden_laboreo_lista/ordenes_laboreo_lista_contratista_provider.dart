
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';

class OrdenesLaboreoContratistaProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<OrdenesLaboreosContratistaResponse> obtenerOrdenesLaboreosContratista(OrdenesLaboreosContratistaRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/ObtenerOrdenesLaboreosContratista", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : req.itemResumenContratista!.gEconomicoId,
                                              "empresaId"             : req.itemResumenContratista!.empresaId,
                                              "contratistaId"         : req.itemResumenContratista!.contratistaId,
                                              "pageNro"               : req.pageNro,
                                              "pageSize"              : req.pageSize,
                                              "filtrosOLs"            : req.filtrosOLs,
                                            });

    return OrdenesLaboreosContratistaResponse.fromJson(r.data);  

  }

}