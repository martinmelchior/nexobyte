import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import 'model/notificacion_model.dart';


class NotificacionesListaProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<NotificacionesListaResponse> obtenerNotificaciones(NotificacionesListaRequest req) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerNotificaciones", 
                                          data: {
                                            "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            "pageNro"           : req.pageNro,
                                            "pageSize"          : req.pageSize,
                                          });

    return NotificacionesListaResponse.fromJson(r.data);  

  }

  //-- ADD 2.3
  //*------------------------------------------------------------------------------------------ eliminarTodasLasNotificaciones
  Future<void> eliminarTodasLasNotificaciones() async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    await _dio.post("/usuarios/eliminarTodasLasNotificaciones", 
                      data: {
                        "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                      });

  }

  //-- ADD 2.3
  //*------------------------------------------------------------------------------------------ marcarTodasComoLeidas
  Future<void> marcarTodasComoLeidas() async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    await _dio.post("/usuarios/marcarTodasComoLeidas", 
                      data: {
                        "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                      });

  }

}