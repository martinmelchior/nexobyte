

import 'package:get/get.dart';

import 'agregar_articulo_a_lotes_controller.dart';


class AgregarArticuloALotesBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AgregarArticuloALotesController>(() => AgregarArticuloALotesController());
  }

}