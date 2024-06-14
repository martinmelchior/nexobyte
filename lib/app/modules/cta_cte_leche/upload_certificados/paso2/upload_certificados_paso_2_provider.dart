
import 'dart:io';

import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class UploadCertificadosPaso2Provider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();


  //*-------------------------------------------------------------------- uploadCertificados
  Future<bool> uploadCertificados(List<XFile> rxImagenes, CtaCteLecheResumenDeLitrosMesItem item) async {
   
    var formData = d.FormData();
    
    for (var file in rxImagenes) {
      formData.files.addAll([
        MapEntry(file.name, await d.MultipartFile.fromFile(File(file.path).path)),
      ]);
    }
    
    formData.fields.addAll([
      MapEntry("empresaId", item.empresaId.toString()),
      MapEntry("clienteId", item.clienteId.toString()),
      MapEntry("tamboId", item.tamboId.toString()),
    ]);

    //-- Envio el token
    _dio.options.headers = { HttpHeaders.authorizationHeader: "Bearer " + PreferenciasDeUsuarioStorage.tokenDeAcceso };
    
    final d.Response r = await _dio.post("/usuarios/uploadCertificados",
                                    data: formData,
                                    options: d.Options(
                                      headers: {
                                        "Content-Type": "multipart/form-data"
                                      }
                                      )
                                    );

    return true;

  }

}