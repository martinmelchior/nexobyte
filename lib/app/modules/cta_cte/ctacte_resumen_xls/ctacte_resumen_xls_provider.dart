

import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';


class CtaCteResumenXlsProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<GenerarResumenXlsPdfResponse> generarResumenXlsPdf(DetalleCtaCteRequest req, bool _enDolares) async {
   
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/generarResumenXlsPdf", 
                                            data: {
                                              "tokenDeRefresco"   : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "resumenDeSaldoItem": req.ctaCteResumenDeSaldosItem,
                                              "fd"                : req.fd,
                                              "fh"                : req.fh,
                                              "pageNro"           : req.pageNro,
                                              "pageSize"          : req.pageSize,
                                              "fieldName"         : req.fieldName,
                                              "isAsc"             : req.isAsc,
                                              "ultimoSaldo"       : req.ultimoSaldo,
                                              "enDolares"         : _enDolares,
                                            });

    return GenerarResumenXlsPdfResponse.fromJson(r.data);  

  }



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
