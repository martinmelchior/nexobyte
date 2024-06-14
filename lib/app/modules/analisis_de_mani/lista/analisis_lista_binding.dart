
import 'package:get/get.dart';
import 'analisis_lista_controller.dart';
import 'analisis_lista_provider.dart';

class AnalisisListaBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AnalisisListaController>(() => AnalisisListaController());
    Get.lazyPut<AnalisisListaProvider>(() => AnalisisListaProvider());
  }

} 