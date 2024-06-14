

import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as d;

import '../model/adelantos_model.dart';


class EfectivoItemProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ObtenerCtasCtesOrigenResponse> obtenerCtasCtesOrigen() async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/obtenerCtasCtesOrigen", 
                                            data: {
                                              "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            });

    return ObtenerCtasCtesOrigenResponse.fromJson(r.data);

  }

}