
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import '../model.dart';

class VerComprobanteSinApiRestProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  //*-------------------------------------------------------------------------------------------------------------------------- obtenerArchivoDeComprobante
  Future<DownloadComprobanteResponse> obtenerArchivoDeComprobante(DownloadComprobanteRequest request) async {
    //-- Envio TA
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    final d.Response r = await _dio.post("/usuarios/GetFiles", 
                                            data: {
                                              "tokenDeRefresco"       : PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              "gEconomicoId"          : request.gEconomicoId,
                                              "empresaId"             : request.empresaId,
                                              "guidComprobante"       : request.guidComprobante,
                                              "ctaCteId"              : request.ctaCteId,
                                            });
                                            
    return DownloadComprobanteResponse.fromJson(r.data);  
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