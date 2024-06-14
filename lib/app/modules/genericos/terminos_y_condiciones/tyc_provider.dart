

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

import 'model/tyc_model.dart';


class TyCProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<TyCResponse> obtenerTyC() async {
   
    final d.Response r = await _dio.post("/usuarios/obtenerTyC", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco, 
                                            });
    return TyCResponse.fromJson(r.data);  

  }


  Future<AceptoTyCResponse> aceptarTyC() async {
   
    final d.Response r = await _dio.post("/usuarios/aceptarTyC", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco, 
                                            });
    return AceptoTyCResponse.fromJson(r.data);  

  }

}