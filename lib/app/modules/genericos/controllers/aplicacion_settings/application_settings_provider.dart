

import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/application_settings_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

class ApplicationSettingsProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<ApplicationSettingsResponse> loadApplicationSettings(ApplicationSettingsRequest request) async {

    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };

    final d.Response r = await _dio.post("/usuarios/ApplicationSettings", data: request);
    
    return ApplicationSettingsResponse.fromJson(r.data);  
  }

}