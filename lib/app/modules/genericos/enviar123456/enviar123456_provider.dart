
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class Enviar123456Provider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<void> setContrasenia123456() async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = { "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco };
    await _dio.post("/usuarios/setContrasenia123456", data: _data);
  }

}