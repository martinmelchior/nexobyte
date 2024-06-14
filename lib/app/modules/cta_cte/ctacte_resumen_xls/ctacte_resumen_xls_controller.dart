

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:path_provider/path_provider.dart';

import 'ctacte_resumen_xls_provider.dart';

class CtaCteResumenXlsController extends GetxController with StateMixin<GenerarResumenXlsPdfResponse> {

  CtaCteResumenXlsController();
  final CtaCteResumenXlsProvider _provider = Get.find<CtaCteResumenXlsProvider>();

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = DetalleCtaCteRequest();

  GenerarResumenXlsPdfResponse _response = GenerarResumenXlsPdfResponse(); 

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  bool enDolares = false;

  String fullPath = '';
  String link = '';
  String fullPathPdf = '';
  String linkPdf = '';

  //*------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    //-- ADD 2.2
    request.ctaCteResumenDeSaldosItem = itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;  // * lo recibo como parametro
    enDolares = Get.arguments["enDolares"] as bool;
  }

  //*------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await generarResumenXlsPdf(enDolares);
    super.onReady();
  }


  // * ----------------------------------------------------------------------------------------------------------- generarResumenXls
  Future<void> generarResumenXlsPdf(_enDolares) async {
    
    try {
      change(null, status: RxStatus.loading());
      request.pageSize = 20000;
      _response = await _provider.generarResumenXlsPdf(request, _enDolares);
      link = _response.link!;

      var tempDir = await getTemporaryDirectory();

      //*-- Download XLS
      fullPath = tempDir.path + "/${_response.fileName}";
      await _provider.downloadToLocal(_response.link!, fullPath);

      //*-- Download PDF
      fullPathPdf = tempDir.path + "/${_response.fileNamePdf}";
      await _provider.downloadToLocal(_response.linkPdf!, fullPathPdf);

      change(_response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
  }

  
}