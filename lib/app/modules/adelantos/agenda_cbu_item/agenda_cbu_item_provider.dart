import 'dart:io';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';

import '../model/adelantos_model.dart';

class AgendaCbuItemProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();
    
  //*------------------------------------------------------------------------------------------ saveCbu
  Future<bool> insertarCbu(AgendaCbu cbu) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/insertarCbu", data: { "cbu": cbu });
    return r.data;  
  }

  //*------------------------------------------------------------------------------------------ saveCbu
  Future<bool> updateCbu(AgendaCbu cbu) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/updateCbu", data: { "cbu": cbu });
    return r.data;  
  }
  
  //*------------------------------------------------------------------------------------------ obtener cbu
  Future<AgendaCbu> obtenerCbu(int id) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerCbu", data: { "id": id });
    return AgendaCbu.fromJson(r.data);  
  }

  //*------------------------------------------------------------------------------------------ saveCbu
  Future<bool> obtenerTiposDeCuentas(GenericoRequest gr) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerTiposDeCuentas", 
                                            data: {
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId":     gr.gEconomicoId,
                                              "empresaId":        gr.empresaId,
                                              "clienteId":        gr.clienteId,
                                            });

    return r.data;  
  }
}