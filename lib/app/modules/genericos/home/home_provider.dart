


import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/posicionesgps.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/model/model_cotizaciones.dart';

//-- ADD 2.4
class HomeProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<CotizacionCerealesYMonedasResponse> obtenerCotizacionesMonedasYCereales() async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/obtenerCotizacionesMonedasYCereales", 
                                          data: {
                                            "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                          });

    return CotizacionCerealesYMonedasResponse.fromJson(r.data);  

  }

  //*-- enviar ubicacion
  //*--------------------------------------------------------
  Future<UbicacionResponse> guardarUbicacion() async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/guardarUbicacion", 
                                          data: {
                                            "tokenDeRefresco":  PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            "latitud":          PreferenciasDeUsuarioStorage.latitud,
                                            "longitud":         PreferenciasDeUsuarioStorage.longitud,
                                            "place":            PreferenciasDeUsuarioStorage.localidad + ", " + PreferenciasDeUsuarioStorage.cp + ", " + PreferenciasDeUsuarioStorage.pais
                                          });

    return UbicacionResponse.fromJson(r.data);  

  }



}