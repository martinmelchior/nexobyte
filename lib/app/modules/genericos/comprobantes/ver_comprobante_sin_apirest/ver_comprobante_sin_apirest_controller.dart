import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import '../model.dart';
import 'ver_comprobante_sin_apirest_provider.dart';
import 'package:path_provider/path_provider.dart';

class VerComprobanteSinApiRestController extends GetxController with StateMixin<DownloadComprobanteResponse> {

  final VerComprobanteSinApiRestProvider _provider = Get.find<VerComprobanteSinApiRestProvider>();

  VerComprobanteSinApiRestController();

  late DownloadComprobanteResponse response;
  
  Rx<String> archivo = ''.obs;
  String fileName = '';
  String fileUrl = '';
  String filePathLocal = '';

  @override
  void onInit() {
    super.onInit();
    response = Get.arguments as DownloadComprobanteResponse;
  }

  //*------------------------------------------------------------ Consulto a API 
  @override
  void onReady() async {
    try {
      EstadisticasDeUso.send("VISUALIZA MULTIPLES Comprobantes");
      change(null, status: RxStatus.loading());
      archivo.value = response.fileName!;
      if (response.fileName == '')
      {
        change(null, status: RxStatus.empty());
      }
      else
      {
        change(response, status: RxStatus.success());
      }
    }
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    super.onReady();
  }

  //*------------------------------------------------------------ onShowSelectedFile
  onShowSelectedFile(DownloadComprobante comprobante) {

    DownloadComprobanteResponse newResponse = DownloadComprobanteResponse(fileName: '', fileUrl: '');

    archivo.value = comprobante.fileName!;

    if (comprobante.fileUrl == response.fileUrl)
    {
      //*-- Selecciono el mismo que estoy viendo, no hago nada !!!
      return;
    }
    else
    {
      //*-- Cargo al seleccionado como el cromprobante MAIN
      newResponse.fileExtension = comprobante.fileExtension;
      newResponse.fileName = comprobante.fileName;
      newResponse.fileUrl = comprobante.fileUrl;

      List<DownloadComprobante> lista = [];
      lista.add(DownloadComprobante(fileExtension: response.fileExtension, fileName: response.fileName, fileUrl: response.fileUrl));
      for (DownloadComprobante cmpViejo in response.listaDeComprobantes) {
        if (cmpViejo.fileUrl != comprobante.fileUrl)
        {
          lista.add(cmpViejo);
        }
      }
      newResponse.listaDeComprobantes = lista;

      response = newResponse;
      
      change(response, status: RxStatus.success());
    }

  }
  
  //*------------------------------------------------------------ descargar archivo al movil
  Future<void> descargarYCompartir() async {

    try {
      var tempDir = await getTemporaryDirectory();

      //*-- Download a local
      filePathLocal = tempDir.path + "/${response.fileName}.${response.fileExtension}";
      await _provider.downloadToLocal(response.fileUrl!, filePathLocal);

      await Share.shareXFiles([XFile(filePathLocal)], subject: response.fileName, text: 'Compartir Archivo');
    }
    catch (e) {
      Get.snackbar(
        "ERROR",
        "Parece que ocurrió un error al intentar descargar el archivo !",
        snackPosition: SnackPosition.TOP,
        icon: const Icon(
          Icons.error,
          color: kErrorTextColor,
        ),
        backgroundColor: kErrorBackColor,
        colorText: kErrorTextColor,
        borderRadius: 0.0,
        margin: const EdgeInsets.all(0),
      );
    }

  }



  

}
