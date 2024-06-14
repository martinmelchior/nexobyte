

import 'package:get/get.dart';
import 'liquidaciones_lista_controller.dart';
import 'liquidaciones_lista_provider.dart';

class LiquidacionesListaBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LiquidacionesListaController>(() => LiquidacionesListaController());
    Get.lazyPut<LiquidacionesListaProvider>(() => LiquidacionesListaProvider());
  }
}