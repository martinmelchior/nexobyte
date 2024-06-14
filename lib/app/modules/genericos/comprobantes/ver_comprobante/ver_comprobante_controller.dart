import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import '../model.dart';
import 'ver_comprobante_provider.dart';
import 'package:path_provider/path_provider.dart';

class VerComprobanteController extends GetxController with StateMixin<DownloadComprobanteResponse> {

  final VerComprobanteProvider _provider = Get.find<VerComprobanteProvider>();

  VerComprobanteController();

  Rx<String> archivo = ''.obs;
  DownloadComprobanteResponse response = DownloadComprobanteResponse(fileName: '', fileUrl: '');
  late DownloadComprobanteRequest request;
  
  String fileName = '';
  String fileUrl = '';
  String filePathLocal = '';
  final tituloPage = "Visualización de\nComprobante(s)".obs;

  @override
  void onInit() {
    super.onInit();
    request = Get.arguments as DownloadComprobanteRequest;
    if (request.tituloPage != null && request.tituloPage != '')
    {
      tituloPage.value = request.tituloPage!;
    }
  }

  //*------------------------------------------------------------ Consulto a API 
  @override
  void onReady() async {
    try {
      EstadisticasDeUso.send("VISUALIZA Comprobante");

      change(null, status: RxStatus.loading());
      response = await _provider.obtenerArchivoDeComprobante(request);
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

      Get.offAndToNamed(AppRoutes.rVerComprobanteSinApiRest, arguments: newResponse );
    }

  }

  //*------------------------------------------------------------ descargar archivo al movil
  Future<void> descargarYCompartir() async {

    try {
      var tempDir = await getTemporaryDirectory();

      String _subject = response.fileName!;

      //*-- Download a local
      if (request.comprobanteAliasName != null && request.comprobanteAliasName != '')
      {
        _subject = request.comprobanteAliasName!;
        filePathLocal = tempDir.path + "/${request.comprobanteAliasName}.${response.fileExtension}";
      }
      else
      {
        filePathLocal = tempDir.path + "/${response.fileName}.${response.fileExtension}";
      }
      await _provider.downloadToLocal(response.fileUrl!, filePathLocal);
 
      await Share.shareXFiles([XFile(filePathLocal)], subject: _subject, text: 'Compartir Archivo');
    }
    catch (e) {
      Get.snackbar(
        "ERROR",
        "Parece que ocurrió un error al intentar descargar el archivo !",
        snackPosition: SnackPosition.TOP,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: kErrorBackColor,
        colorText: Colors.white,
        borderRadius: 0.0,
        margin: const EdgeInsets.all(0),
      );
    }

  }



  

}
