import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/generico_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'comp_pendientes_download_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


class CompPendientesDownloadController extends GetxController with StateMixin<FileDataXlsPdfResponse> {

  FileDataXlsPdfResponse response = FileDataXlsPdfResponse();
  final CompPendientesDownloadProvider provider = Get.find<CompPendientesDownloadProvider>();
  late CtaCteResumenDeSaldosItem itemResumenCtaCte;

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.onClose();
  }
  

  //*----------------------------------------------------------------------------- onInit
  @override
  void onInit() {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);

    super.onInit();
    itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;  // * lo recibo como parametro  
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await generarListadoComprobantesPendientesXlsPdf();
  }

   

  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> generarListadoComprobantesPendientesXlsPdf() async {
    try {
      change(null, status: RxStatus.loading());
      response = await provider.generarListadoComprobantesPendientesXlsPdf(itemResumenCtaCte);
      if (response.fileNamePdf == '')
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
    
  }


  //*------------------------------------------------------------ descargar archivo al movil
  Future<void> descargarYCompartir() async {

    try {
      var tempDir = await getTemporaryDirectory();

      String _subject = "Listado de Comprobantes Pendientes";
     
      String filePathLocal = tempDir.path + "/${response.fileNamePdf}";
      
      await provider.downloadToLocal(response.linkPdf!, filePathLocal);
 
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