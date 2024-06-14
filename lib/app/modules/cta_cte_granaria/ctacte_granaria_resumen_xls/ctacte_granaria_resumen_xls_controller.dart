

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:path_provider/path_provider.dart';

import 'ctacte_granaria_resumen_xls_provider.dart';

class CtaCteGranariaResumenXlsController extends GetxController with StateMixin<GenerarResumenXlsPdfResponse> {

  CtaCteGranariaResumenXlsController();
  final CtaCteGranariaResumenXlsProvider _provider = Get.find<CtaCteGranariaResumenXlsProvider>();

  final itemCtaCteProductorEspecieCosechaItem = Get.arguments as CtaCteProductorEspecieCosechaItem;
  
  final request = DetalleCtaCteGranariaRequest();
  String fullPath = '';
  String link = '';

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    //*-- CARGO DATA ANTES DEL onReady()
    //*------------------------------------------------------------------------
    request.clienteId = itemCtaCteProductorEspecieCosechaItem.clienteId;
    request.cosecha = itemCtaCteProductorEspecieCosechaItem.cosecha;
    request.empresaId = itemCtaCteProductorEspecieCosechaItem.empresaId;
    request.especieId = itemCtaCteProductorEspecieCosechaItem.especieId;
    request.ultimoSaldo = itemCtaCteProductorEspecieCosechaItem.disponibleKgs;
    request.tokenDeRefresco = PreferenciasDeUsuarioStorage.tokenDeRefresco;
    request.pageNro = 1;
  }

  //*------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await generarResumenGranarioXls();
    super.onReady();
  }


  // * ----------------------------------------------------------------------------------------------------------- generarResumenXls
  Future<void> generarResumenGranarioXls() async {
    
    GenerarResumenXlsPdfResponse _response = GenerarResumenXlsPdfResponse(); 
    
    try {
      change(null, status: RxStatus.loading());
      request.pageSize = 20000;
      _response = await _provider.generarResumenGranarioXls(request, itemCtaCteProductorEspecieCosechaItem);
      link = _response.link!;

      var tempDir = await getTemporaryDirectory();
      fullPath = tempDir.path + "/${_response.fileName}";
      await _provider.downloadToLocal(_response.link!, fullPath);
      change(_response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
  }

  
}