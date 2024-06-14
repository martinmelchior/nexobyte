

import 'package:get/get.dart';

import 'agregar_articulo_controller.dart';

class AgregarArticuloBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AgregarArticuloController>(() => AgregarArticuloController());
  }

}