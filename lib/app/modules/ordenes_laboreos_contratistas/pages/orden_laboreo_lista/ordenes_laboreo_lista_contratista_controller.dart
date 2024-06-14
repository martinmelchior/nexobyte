import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ordenes_laboreo_lista_contratista_repository.dart';

class OrdenesLaboreoContratistaController extends GetxController with StateMixin<OrdenesLaboreosContratistaResponse> {

  final ScrollController scrollController = ScrollController();
  final OrdenesLaboreoContratistaRepository _repository = Get.find<OrdenesLaboreoContratistaRepository>();

  Rx<bool> filtering = false.obs;
  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = OrdenesLaboreosContratistaRequest();
  EAResourcesResponse recursosEA = EAResourcesResponse();
  
    // * ------------------------------------------- Filtros
  Rx<FiltrosOLsCon> filtrosOL = FiltrosOLsCon().obs;

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  OrdenesLaboreosContratistaResponse dataShowed = OrdenesLaboreosContratistaResponse();

  void limpiarFiltros() async {
    filtering.value = false;
    filtrosOL = FiltrosOLsCon().obs;
    filtrosOL.refresh();
    obtenerOrdenesLaboreosContratista();
  }

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();
    
    // * --------- Paso entidad de resumen para tener todos los datos
    request.itemResumenContratista = Get.arguments["itemResumenContratista"] as OrdenesLaboreosResumenDeContratistasItem;
    recursosEA = Get.arguments["recursosEA"] as EAResourcesResponse;

    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerOrdenesLaboreosContratista();
      }
     });
  }

  

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerOrdenesLaboreosContratista();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerOrdenesLaboreoContratista
  Future<void> obtenerOrdenesLaboreosContratista() async {
    
    OrdenesLaboreosContratistaResponse _response = OrdenesLaboreosContratistaResponse(); 
    
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

      if (filtrosOL.value.especie != null || filtrosOL.value.ea != null || filtrosOL.value.campania != null || filtrosOL.value.laboreo != null)
      {
        filtering.value = true;
      }
      else
      {
        filtering.value = false;
      }


      _response = await _repository.obtenerOrdenesLaboreosContratista(request);
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

      if (dataShowed.listaOLsUsuario.isEmpty)
      {
        change(null, status: RxStatus.empty());
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
    finally {
      loading.value = false;
    }
  }

  
}