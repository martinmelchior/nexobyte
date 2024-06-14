


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'model/notificacion_model.dart';
import 'notificaciones_lista_repository.dart';



class NotificacionesListaController extends GetxController with StateMixin<NotificacionesListaResponse> {

  final ScrollController scrollController = ScrollController();
  final NotificacionesListaRepository _repository = Get.find<NotificacionesListaRepository>();

  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  // * ----------------------------------------------------------------------------- Para mantener estados  
  final request = NotificacionesListaRequest();

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  NotificacionesListaResponse dataShowed = NotificacionesListaResponse();

  //-- ADD 2.3
  // * ----------------------------------------------------------------------------- Armar Acciones
  final RxList<PopupMenuEntry> acciones = <PopupMenuEntry>[].obs;
  void armarAcciones() {
 
    PopupMenuItem _todasLeidas = const PopupMenuItem<int>(value: 0, child: Text("Marcar todas como leídas", style: TextStyle(color: Colors.black87)));
    PopupMenuItem _elimarTodas = const PopupMenuItem<int>(value: 1, child: Text("Eliminar todas", style: TextStyle(color: kTRedColor)));

    if (dataShowed.listaDeNotificaciones.isNotEmpty)
    {
      acciones.add(_todasLeidas);
      acciones.add(_elimarTodas);
    }
  }

  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();

    // * -------------------------------- agrego listener para ir a buscar otras paginas cuando llegue al final del scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !loading.value) {
        request.pageNro++;  
        obtenerNotificaciones();
      }
     });
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerNotificaciones();
    super.onReady();
  }

  
  // * ----------------------------------------------------------------------------------------------------------- obtenerNotificaciones
  Future<void> obtenerNotificaciones() async {
    
    NotificacionesListaResponse _response = NotificacionesListaResponse(); 
    
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

      _response = await _repository.obtenerNotificaciones(request);
      if (request.pageNro > 1)
      {
        if (_response.listaDeNotificaciones.isNotEmpty)
        {
          dataShowed.listaDeNotificaciones.addAll(_response.listaDeNotificaciones);
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

      if (dataShowed.listaDeNotificaciones.isEmpty)
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
    finally {
      loading.value = false;
    }

    //-- ADD 2.3
    armarAcciones();
    acciones.refresh();
  }

  //-- ADD 2.3
  //*----------------------------------------------------- Eliminar todas
  Future<void> eliminarTodasLasNotificaciones() async {
    
    Get.dialog(const Center(child: kTCpi));
    try {
      await _repository.eliminarTodasLasNotificaciones();
      Get.back();
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }

  //-- ADD 2.3
  //*----------------------------------------------------- Marcar todas como leidas
  Future<void> marcarTodasComoLeidas() async {
    
    Get.dialog(const Center(child: kTCpi));
    try {
      await _repository.marcarTodasComoLeidas();
      Get.back();
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }
}