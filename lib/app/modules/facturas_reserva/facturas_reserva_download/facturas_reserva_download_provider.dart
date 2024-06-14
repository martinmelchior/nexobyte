import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/generico_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class FacturasReservaDownloadProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<FileDataXlsPdfResponse> generarListadoDeArticulosPendientesXlsPdf(CtaCteResumenDeSaldosItem itemResumenCtaCte) async {
   
    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/GenerarListadoDeArticulosPendientesXlsPdf", 
                                            data: {
                                              "tokenDeRefresco": PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "resumenDeSaldoItem": itemResumenCtaCte,
                                            });

    return FileDataXlsPdfResponse.fromJson(r.data);  

  }


  //*-------------------------------------------------------------------------------------------------------------------------- downloadToLocal
  Future<void> downloadToLocal(String url, String savePath) async {
    try {
      d.Response response = await _dio.get(
        url,
        //onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: d.Options(
            responseType: d.ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
        rethrow;
    }
  }
}