
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as d;

import '../model/adelantos_model.dart';


class AdelantoListaProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

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
                                            });

    return ObtenerSolicitudesResponse.fromJson(r.data);  

  }

  obtenersol(ObtenerSolicitudesRequest request) {}

}