


import 'package:get/get.dart';

import 'notificaciones_lista_controller.dart';
import 'notificaciones_lista_provider.dart';
import 'notificaciones_lista_repository.dart';

class NotificacionesListaBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<NotificacionesListaController>(() => NotificacionesListaController());
    Get.lazyPut<NotificacionesListaRepository>(() => NotificacionesListaRepository());
    Get.lazyPut<NotificacionesListaProvider>(() => NotificacionesListaProvider());
      
  }

} 