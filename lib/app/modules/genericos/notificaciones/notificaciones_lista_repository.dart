

import 'package:get/get.dart';
import 'model/notificacion_model.dart';
import 'notificaciones_lista_provider.dart';


class NotificacionesListaRepository {

  NotificacionesListaProvider apiProvider = Get.find<NotificacionesListaProvider>();

  Future<NotificacionesListaResponse> obtenerNotificaciones(NotificacionesListaRequest notificacionesRequest) async {
    return apiProvider.obtenerNotificaciones(notificacionesRequest);
  }

  //-- ADD 2.3
  Future<void> eliminarTodasLasNotificaciones() async {
    return apiProvider.eliminarTodasLasNotificaciones();
  }

  //-- ADD 2.3
  Future<void> marcarTodasComoLeidas() async {
    return apiProvider.marcarTodasComoLeidas();
  }
}
