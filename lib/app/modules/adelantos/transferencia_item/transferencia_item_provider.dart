

import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as d;

import '../model/adelantos_model.dart';


class TransferenciaItemProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerAgendaCbu
  Future<AgendaCbuResponse> obtenerAgendaCbu(TipoDeCuenta tipoDeCuenta) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = { 
                                    "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "tipoDeCuenta": tipoDeCuenta.toValueText,
                                 };
    final d.Response r = await _dio.post("/usuarios/obtenerAgendaCbu", data: _data);
    return AgendaCbuResponse.fromJson(r.data);  
  }
}