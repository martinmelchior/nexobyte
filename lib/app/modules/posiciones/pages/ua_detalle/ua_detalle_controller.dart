import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ua_detalle_repository.dart';

class UAUsuarioDetalleController extends GetxController with StateMixin<UAUsuarioDetalleResponse> {

  final ScrollController scrollController = ScrollController();
  final UAUsuarioDetalleRepository _repository = Get.find<UAUsuarioDetalleRepository>();

  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  var letra = ''.obs;
  var showLetra = true.obs;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = UAUsuarioDetalleRequest();

    // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  UAUsuarioDetalleResponse dataShowed = UAUsuarioDetalleResponse();

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final uaResumenItem = Get.arguments as UAUsuarioResumenItem;


  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    // * --------- Paso entidad de resumen para tener todos los datos
    request.uaResumenItem = uaResumenItem;

    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerUAUsuarioDetalle();
      }
     });
  }

  

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerUAUsuarioDetalle();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerOrdenesLaboreoUsuario
  Future<void> obtenerUAUsuarioDetalle() async {
    
    UAUsuarioDetalleResponse _response = UAUsuarioDetalleResponse(); 
    
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

      _response = await _repository.obtenerUAUsuarioDetalle(request);
      if (request.pageNro > 1)
      {
        if (_response.listaUAUsuarioDetalleItem.isNotEmpty)
        {
          dataShowed.listaUAUsuarioDetalleItem.addAll(_response.listaUAUsuarioDetalleItem);
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