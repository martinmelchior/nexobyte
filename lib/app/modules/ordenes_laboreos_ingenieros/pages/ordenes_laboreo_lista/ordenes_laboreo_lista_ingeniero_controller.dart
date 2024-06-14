import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ordenes_laboreo_lista_ingeniero_provider.dart';



class OrdenesLaboreoListaIngenieroController extends GetxController with StateMixin<OrdenesLaboreosIngenieroResponse> {

  final ScrollController scrollController = ScrollController();
  final OrdenesLaboreoListaIngenieroProvider _provider = Get.find<OrdenesLaboreoListaIngenieroProvider>();

  EAResourcesResponse recursosEA = EAResourcesResponse();
  Rx<bool> filtering = false.obs;
  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  // * ------------------------------------------- Filtros
  Rx<FiltrosOLsIng> filtrosOL = FiltrosOLsIng().obs;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = OrdenesLaboreosIngenieroRequest();

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  OrdenesLaboreosIngenieroResponse dataShowed = OrdenesLaboreosIngenieroResponse();

  void limpiarFiltros() async {
    filtering.value = false;
    filtrosOL = FiltrosOLsIng().obs;
    filtrosOL.refresh();
    obtenerOrdenesLaboreosIngeniero();
  }

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();
    
    // * --------- Paso entidad de resumen para tener todos los datos
    request.itemResumenIngeniero = Get.arguments["itemResumenIngeniero"] as OrdenesLaboreosResumenDeIngenieroItem;
    recursosEA = Get.arguments["recursosEA"] as EAResourcesResponse;

    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerOrdenesLaboreosIngeniero();
      }
     });
  }

  

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerOrdenesLaboreosIngeniero();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerOrdenesLaboreoListaIngeniero
  Future<void> obtenerOrdenesLaboreosIngeniero() async {
    
    OrdenesLaboreosIngenieroResponse _response = OrdenesLaboreosIngenieroResponse(); 
    
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

      //*---------------------------------- aplico filtros
      request.filtrosOLs = filtrosOL.value;

      if (filtrosOL.value.especie != null || 
          filtrosOL.value.ea != null || 
          filtrosOL.value.campania != null || 
          filtrosOL.value.laboreo != null ||
          filtrosOL.value.contratista != null ||
          filtrosOL.value.verSoloMisOLs == true)
      {
        filtering.value = true;
      }
      else
      {
        filtering.value = false;
      }

      _response = await _provider.obtenerOrdenesLaboreosIngeniero(request);
      if (request.pageNro > 1)
      {
        if (_response.listaOLsUsuario.isNotEmpty)
        {
          dataShowed.listaOLsUsuario.addAll(_response.listaOLsUsuario);
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