
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';

import '../../../data/models/preferencias_de_usuario_model.dart';
import '../model/adelantos_model.dart';

class AgendaCbuListProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerMovimientosInternos
  Future<AgendaCbuResponse> obtenerAgendaCbu(String tipoDeCuenta) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = { 
                                "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                "tipoDeCuenta": tipoDeCuenta,
                              };
    final d.Response r = await _dio.post("/usuarios/obtenerAgendaCbu", data: _data);
    return AgendaCbuResponse.fromJson(r.data);  
  }

  //*------------------------------------------------------------------------------------------ anularMovimientoInterno
  Future<bool> eliminarAgendaCbu(int id) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/eliminarCbu", data: { "id": id });
    return r.data;  
  }
  
}