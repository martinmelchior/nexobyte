

import 'package:get/get.dart';

import 'detalle_entregas_leche_controller.dart';
import 'detalle_entregas_leche_provider.dart';
import 'detalle_entregas_leche_repository.dart';


class DetalleEntregasLecheBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<DetalleEntregasLecheController>(() => DetalleEntregasLecheController());
    Get.lazyPut<DetalleEntregasLecheRepository>(() => DetalleEntregasLecheRepository());
    Get.lazyPut<DetalleEntregasLecheProvider>(() => DetalleEntregasLecheProvider());
  }
  
}