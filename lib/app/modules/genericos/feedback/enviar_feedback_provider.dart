
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import 'model.dart';

      
class EnviarFeedbackProvider {

  final d.Dio _dio = Get.find<d.Dio>();

  //*------------------------------------------------------------------------------------------ obtenerMovimientosInternos
  Future<EnviarFeedbackResponse> enviarFeedback(EnviarFeedbackRequest req) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    Map<String, dynamic> _data = {
                                    "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                    "tipo":            req.tipo,
                                    "mensaje":         req.mensaje,
                                  };

    final d.Response r = await _dio.post("/usuarios/enviarFeedback", data: _data);

    return EnviarFeedbackResponse.fromJson(r.data);  
  }

}