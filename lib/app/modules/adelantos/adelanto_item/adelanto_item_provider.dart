

import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as d;

import '../model/adelantos_model.dart';


class AdelantoItemProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  //*---------------------------------------------------------------------------- obtenerCtasCtesOrigen
  Future<ObtenerCtasCtesOrigenResponse> obtenerCtasCtesOrigen() async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerCtasCtesOrigen", 
                                            data: {
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return ObtenerCtasCtesOrigenResponse.fromJson(r.data);

  }

  //*---------------------------------------------------------------------------- enviarSolicitud
  Future<bool> enviarSolicitud(Solicitud solicitud, GenericoRequest requestGenerico) async {
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    Map<String, dynamic> _data = { 
                              "request":  requestGenerico,
                              "solicitud":  solicitud,
                            };
                            
    await _dio.post("/usuarios/GuardarSolicitud", data: _data);
    return true;
  }

  //*----------------------------------------------------------------------------------------- obtenerSolicitudes
  Future<ObtenerSolicitudesResponse> obtenerSolicitudes(GenericoRequest gec) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerSolicitudes", 
                                            data: {
                                              "tokenDeRefresco":  gec.tokenDeRefresco,
                                              "gEconomicoId":     gec.gEconomicoId,
                                              "empresaId":        gec.empresaId,
                                              "clienteId":        gec.clienteId,
                                              "solicitudId":      gec.solicitudId,
                                            });

    return ObtenerSolicitudesResponse.fromJson(r.data);  

  }


}