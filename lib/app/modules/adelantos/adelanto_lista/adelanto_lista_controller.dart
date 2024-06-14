import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cta_cte_resumen_saldo.dart';
import '../../../data/models/preferencias_de_usuario_model.dart';
import '../model/adelantos_model.dart';
import 'adelanto_lista_provider.dart';

class AdelantoListaController extends GetxController with StateMixin<ObtenerSolicitudesResponse> {

  AdelantoListaController();

  late GenericoRequest gec;
  final ScrollController scrollController = ScrollController();
  final AdelantoListaProvider _provider = Get.find<AdelantoListaProvider>();

  final request = ObtenerSolicitudesRequest();
  ObtenerSolicitudesResponse dataShowed = ObtenerSolicitudesResponse();

  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  
  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {

    itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;
    gec = GenericoRequest(
      tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
      gEconomicoId: itemResumenCtaCte.gEconomicoId, 
      empresaId: itemResumenCtaCte.empresaId, 
      clienteId: itemResumenCtaCte.clienteId,
      solicitudId: null,
    );
    
    super.onInit();
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerSolicitudes(gec);
    EstadisticasDeUso.send("Solicitudes de Adelantos");
    super.onReady();
  }

  
  
  // * ----------------------------------------------------------------------------------------------------------- obtenerSolicitudes
  Future<void> obtenerSolicitudes(GenericoRequest gec) async {
    
    ObtenerSolicitudesResponse _response = ObtenerSolicitudesResponse(); 
   
    try {
      change(null, status: RxStatus.loading());
      _response = await _provider.obtenerSolicitudes(gec);
      dataShowed = _response;
      if (dataShowed.listaDeSolicitudes.isEmpty)
      {
        change(dataShowed, status: RxStatus.empty());
      }
      else
      {
        change(dataShowed, status: RxStatus.success());
      }
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
  }
}



