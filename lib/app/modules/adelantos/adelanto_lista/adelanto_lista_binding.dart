import 'package:get/get.dart';
import 'adelanto_lista_controller.dart';
import 'adelanto_lista_provider.dart';

class AdelantoListaBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AdelantoListaController>(() => AdelantoListaController());
    Get.lazyPut<AdelantoListaProvider>(() => AdelantoListaProvider());
  }
}