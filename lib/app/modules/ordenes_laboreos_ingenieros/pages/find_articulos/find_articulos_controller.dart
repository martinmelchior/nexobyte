import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/articulos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_1_controller.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'find_articulos_provider.dart';


class FindArticulosController extends GetxController with StateMixin<FindArticulosResponse> {

  final ScrollController scrollController = ScrollController();
  final FindArticulosProvider _provider = Get.find<FindArticulosProvider>();
  final OrdenLaboreoItemPaso1Controller paso1Controller = Get.find<OrdenLaboreoItemPaso1Controller>();

  TextEditingController txtSearchController = TextEditingController();
  EAResourcesRequest recursosEA = EAResourcesRequest();
  Rx<bool> filtering = false.obs;
  Rx<bool> loading = false.obs;
  bool allLoaded = false;
  bool addInsumoAUnLote = false;

  Rx<Lote> lote = Lote().obs;
  double _precioDolar = 0.0;
  int _uaOrigenId = 0;

  // * ------------------------------------------- Filtros
  Rx<FiltrosOLsIng> filtrosOL = FiltrosOLsIng().obs;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = FindArticulosRequest();
  

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  FindArticulosResponse dataShowed = FindArticulosResponse();

  // void limpiarFiltros() async {
  //   filtering.value = false;
  //   filtrosOL = FiltrosOLsIng().obs;
  //   filtrosOL.refresh();
  //   obtenerArticulosOL();
  // }

  Timer? _debounce;
 
  // * ----------------------------------------------------------------------------- onClose
  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  //* ------------------------------------------------------------------------------ Filtro los articulos por nombre
  onSearchChanged(String value) {
    if (value == '') return;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (loading.value == false)
      {
        //-- Cierro keyboard
        FocusManager.instance.primaryFocus?.unfocus();
        await obtenerArticulosOL();
      }
    });
  }

  //* ------------------------------------------------------------------------------ onInit
  @override
  void onInit() {
    super.onInit();

    addInsumoAUnLote = Get.arguments["addInsumoAUnLote"] as bool;
    if (addInsumoAUnLote)
    {
      lote.value = Get.arguments["lote"] as Lote;
    }

    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerArticulosOL();
      }
     }
    );

    
  }
  
  //* ------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    recursosEA = Get.arguments["requestEARerources"] as EAResourcesRequest;
    _precioDolar = Get.arguments["precioDolar"] as double; 
    _uaOrigenId = Get.arguments["uaOrigenId"] as int;
    request.pageSize = 100;
    await obtenerArticulosOL();
    super.onReady();
  }

  
  // * ------------------------------------------------------------------------------- obtenerArticulosOL
  Future<void> obtenerArticulosOL() async {
    
    FindArticulosResponse _response = FindArticulosResponse(); 
    
    try {

      if (allLoaded) {
        return;
      }

      if (loading.value) {
        Get.showSnackbar(const GetSnackBar(
              title: 'ATENCION',
              message: 'Aguarde un instante, estamos realizando otra acción suya !',
              duration: Duration(seconds: 2),));
        return;
      }

      loading.value = true;
      
      // * -------------------------------------------- PAGINA 1 
      if (request.pageNro == 1)
      { 
        change(null, status: RxStatus.loading());
      }

      //*---------------------------------- aplico filtros
      request.empresaId = recursosEA.empresaId;
      request.gEconomicoId = recursosEA.gEconomicoId;
      request.uaOrigenId = _uaOrigenId;
      request.precioDolar = _precioDolar;
      request.findArticulo = txtSearchController.text;

      _response = await _provider.obtenerArticulosOL(request);
      if (request.pageNro > 1)
      {
        if (_response.articulos.isNotEmpty)
        {
          dataShowed.articulos.addAll(_response.articulos);
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

      if (dataShowed.articulos.isEmpty) 
      {
        change(null, status: RxStatus.empty());
      }
      else
      {
        change(dataShowed, status: RxStatus.success());
      }
    } 
    catch(e) {
      loading.value = false;
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    finally {
      loading.value = false;
    }
  }

  
}