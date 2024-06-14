


import 'package:nexobyte/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'movimientos_repository.dart';

class MovimientosController extends GetxController with StateMixin<DetalleCtaCteGranariaResponse> {

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final itemCtaCteProductorEspecieCosechaItem = Get.arguments as CtaCteProductorEspecieCosechaItem;

  final ScrollController scrollController = ScrollController();
  final MovimientosRepository _repository = Get.find<MovimientosRepository>();

  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  DetalleCtaCteGranariaResponse dataShowed = DetalleCtaCteGranariaResponse();

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = DetalleCtaCteGranariaRequest();

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    //*-- CARGO DATA ANTES DEL onReady()
    //*------------------------------------------------------------------------
    request.gEconomicoId = itemCtaCteProductorEspecieCosechaItem.gEconomicoId;
    request.clienteId = itemCtaCteProductorEspecieCosechaItem.clienteId;
    request.cosecha = itemCtaCteProductorEspecieCosechaItem.cosecha;
    request.empresaId = itemCtaCteProductorEspecieCosechaItem.empresaId;
    request.especieId = itemCtaCteProductorEspecieCosechaItem.especieId;
    request.ultimoSaldo = itemCtaCteProductorEspecieCosechaItem.disponibleKgs;
    request.tokenDeRefresco = PreferenciasDeUsuarioStorage.tokenDeRefresco;
    request.pageNro = 1;
    //request.pageSize = 29;

    //*-- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    //*------------------------------------------------------------------------
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerDetalleDeCCG();
      }
     });
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    EstadisticasDeUso.send("CTA CTE GRANOS MOVIMIENTOS");
    super.onReady();
    await obtenerDetalleDeCCG();
  }

  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> obtenerDetalleDeCCG() async {
    
    DetalleCtaCteGranariaResponse _response = DetalleCtaCteGranariaResponse(); 
    
    try {

      if (allLoaded) {
        return;
      }

      loading.value = true;
      
      // * -------------------------------------------- PAGINA 1 tengo que mostrar el loading general 
      if (request.pageNro == 1)
      {
        change(null, status: RxStatus.loading());
      }

      _response = await _repository.obtenerDetalleDeCCG(request);
      if (request.pageNro > 1)
      {
        if (_response.listaDetalleCtaCteGranariaItem.isNotEmpty)
        {
          dataShowed.listaDetalleCtaCteGranariaItem.addAll(_response.listaDetalleCtaCteGranariaItem);
          scrollController.jumpTo(scrollController.position.pixels + 30);
        }
        else
        {
          allLoaded = true;
        }
      }
      else
      {
        dataShowed = _response;
      }

      request.ultimoSaldo = _response.ultimoSaldo;

      change(dataShowed, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    finally {
      loading.value = false;
    }
  }

}