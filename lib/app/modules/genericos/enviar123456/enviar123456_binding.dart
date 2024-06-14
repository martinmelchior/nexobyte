
import 'package:get/get.dart';
import 'enviar123456_controller.dart';
import 'enviar123456_provider.dart';


class Enviar123456Binding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<Enviar123456Controller>(() => Enviar123456Controller());
    Get.lazyPut<Enviar123456Provider>(() => Enviar123456Provider());
  }

}