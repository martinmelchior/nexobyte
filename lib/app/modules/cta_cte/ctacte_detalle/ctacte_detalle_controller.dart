


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ctacte_detalle_repository.dart';

class CtaCteDetalleController extends GetxController with StateMixin<DetalleCtaCteResponse> {

  final ScrollController scrollController = ScrollController();
  final CtaCteDetalleRepository _repository = Get.find<CtaCteDetalleRepository>();

  double ultimoSaldo = 0;
  Rx<bool> loading = false.obs;
  //!-- Add 2.7
  Rx<bool> showResumneOls = false.obs;
  bool allLoaded = false;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = DetalleCtaCteRequest();

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  DetalleCtaCteResponse dataShowed = DetalleCtaCteResponse();

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  //-- ADD 2.2
  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  bool enDolares = false;
  

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    //-- ADD 2.2
    request.ctaCteResumenDeSaldosItem = itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;  // * lo recibo como parametro
    enDolares = Get.arguments["enDolares"] as bool;
    
    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        //-- ADD 2.2
        obtenerDetalleDeCC(enDolares);
      }
     });
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    
    //!-- ADD 2.2
    await obtenerDetalleDeCC(enDolares);

    //!-- Add 2.7
    showResumneOls.value = dataShowed.showResumenOL;

    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  //-- ADD 2.2
  Future<void> obtenerDetalleDeCC(_enDolares) async {
    
    DetalleCtaCteResponse _response = DetalleCtaCteResponse(); 
    
    try {

      if (allLoaded) {
        return;
      }

      loading.value = true;
      
      // * -------------------------------------------- PAGINA 1 
      if (request.pageNro == 1)
      {
        change(null, status: RxStatus.loading());
      }

      //-- ADD 2.2
      _response = await _repository.obtenerDetalleDeCC(request, _enDolares);
      if (request.pageNro > 1)
      {
        if (_response.listaDetalleCtaCteItem!.isNotEmpty)
        {
          dataShowed.listaDetalleCtaCteItem!.addAll(_response.listaDetalleCtaCteItem!);
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

      //-- Cargo ultimo saldo
      request.ultimoSaldo =_response.ultimoSaldo;
      //debugPrint('Devolución: ' + request.ultimoSaldo.toString());

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