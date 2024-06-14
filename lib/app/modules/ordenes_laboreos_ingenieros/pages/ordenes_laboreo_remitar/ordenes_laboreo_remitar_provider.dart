import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

class OrdenesLaboreoRemitarProvider {

  final d.Dio _dio = Get.find<d.Dio>();

 
  //*----------------------------------------------------------------------------------- obtenerCamionesChoferes
  Future<List<CamionChofer>> obtenerCamionesChoferes(RequestCamionChofer req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerCamionesChoferes", 
                                            data: {
                                              "tokenDeRefresco"         : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"            : req.gEconomicoId,
                                              "empresaId"               : req.empresaId,
                                              "transportistaClienteId"  : req.transportistaClienteId,
                                            });

    return List<CamionChofer>.from(r.data.map((x) => CamionChofer.fromJson(x)));  

  }
  

  //*----------------------------------------------------------------------------------- obtenerChoferes
  Future<List<Chofer>> obtenerChoferes(RequestCamionChofer req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerChoferes", 
                                            data: {
                                              "tokenDeRefresco"         : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"            : req.gEconomicoId,
                                              "empresaId"               : req.empresaId,
                                              "transportistaClienteId"  : req.transportistaClienteId,
                                            });

    return List<Chofer>.from(r.data.map((x) => Chofer.fromJson(x)));  

  }
}