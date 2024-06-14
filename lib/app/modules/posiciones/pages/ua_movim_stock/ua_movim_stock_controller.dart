import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ua_movim_stock_repository.dart';

class UAMovimientoStockController extends GetxController with StateMixin<UAMovimientoStockResponse> {

  final ScrollController scrollController = ScrollController();
  final UAMovimientoStockRepository _repository = Get.find<UAMovimientoStockRepository>();

  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = UAMovimientoStockRequest();

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  UAMovimientoStockResponse dataShowed = UAMovimientoStockResponse();

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final uaUsuarioResumenItemMovStockItem = Get.arguments as UAUsuarioDetalleItem;

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();
    
    // * --------- Paso entidad de resumen para tener todos los datos
    request.uaUsuarioResumenItemMovStock = uaUsuarioResumenItemMovStockItem;

    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerUAMovimientosStock();
      }
     });
  }

  

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerUAMovimientosStock();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerOrdenesLaboreoUsuario
  Future<void> obtenerUAMovimientosStock() async {
    
    UAMovimientoStockResponse _response = UAMovimientoStockResponse(); 
    
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

      _response = await _repository.obtenerUAMovimientosStock(request);
      if (request.pageNro > 1)
      {
        if (_response.listaUAMovimientosDeStock.isNotEmpty)
        {
          dataShowed.listaUAMovimientosDeStock.addAll(_response.listaUAMovimientosDeStock);
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