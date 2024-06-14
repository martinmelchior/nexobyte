
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import '../model/analisis_de_mani_model.dart';
import 'analisis_lista_provider.dart';

class AnalisisListaController extends GetxController with StateMixin<ObtenerAnalisisDeManiListaResponse> {

  final ScrollController scrollController = ScrollController();
  final AnalisisListaProvider _provider = Get.find<AnalisisListaProvider>();

  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  //*----------------------------------------------------------------------------- La hago observable porque busco por páginas
  ObtenerAnalisisDeManiListaResponse dataShowed = ObtenerAnalisisDeManiListaResponse(listaDeAnalisisDeMani: const []);

  //*----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  late ResumenAnalisisItem itemResumenAnalisis;
  

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    itemResumenAnalisis = Get.arguments["itemResumenAnalisis"] as ResumenAnalisisItem;  // * lo recibo como parametro
    itemResumenAnalisis.pageNro = 1;
    
    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        itemResumenAnalisis.pageNro++;  
        obtenerAnalisisCerradosLista();
      }
     });
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerAnalisisCerradosLista();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> obtenerAnalisisCerradosLista() async {
    
    ObtenerAnalisisDeManiListaResponse _response = ObtenerAnalisisDeManiListaResponse(listaDeAnalisisDeMani: const []); 
    
    try {

      if (allLoaded) {
        return;
      }

      loading.value = true;
      
      // * -------------------------------------------- PAGINA 1 
      if (itemResumenAnalisis.pageNro == 1)
      {
        change(null, status: RxStatus.loading());
      }

      _response = await _provider.obtenerAnalisisDeManiLista(itemResumenAnalisis);
      if (itemResumenAnalisis.pageNro > 1)
      {
        if (_response.listaDeAnalisisDeMani.isNotEmpty)
        {
          dataShowed.listaDeAnalisisDeMani.addAll(_response.listaDeAnalisisDeMani);
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