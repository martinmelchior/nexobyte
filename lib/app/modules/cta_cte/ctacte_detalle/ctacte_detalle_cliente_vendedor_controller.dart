


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/modules/vendedor/ctacte_detalle/ctacte_detalle_cliente_vendedor_repository.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';


class CtaCteDetalleClienteVendedorController extends GetxController with StateMixin<DetalleCtaCteResponse> {

  final ScrollController scrollController = ScrollController();
  final CtaCteDetalleClienteVendedorRepository _repository = Get.find<CtaCteDetalleClienteVendedorRepository>();

  double ultimoSaldo = 0;
  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = DetalleCtaCteRequest();

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  DetalleCtaCteResponse dataShowed = DetalleCtaCteResponse();

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final itemResumenCtaCte = Get.arguments as CtaCteResumenDeSaldosItem;
  

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();
    //request.pageSize = 100;
    request.ctaCteResumenDeSaldosItem = itemResumenCtaCte;  // * lo recibo como parametro
    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerDetalleDeCC();
      }
     });
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerDetalleDeCC();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> obtenerDetalleDeCC() async {
    
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

      //debugPrint('Envio: ' + request.ultimoSaldo.toString());
      _response = await _repository.obtenerDetalleDeCC(request);
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