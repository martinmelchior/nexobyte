
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/enviar123456/enviar123456_provider.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';


class Enviar123456Controller extends GetxController {

  final Enviar123456Provider _provider = Get.find<Enviar123456Provider>();
  
  Rx<bool> newPassEnviada = false.obs;
  String url = Get.arguments as String;

  @override
  void onReady() async {
    try {

      await _provider.setContrasenia123456();
      newPassEnviada.toggle();
      
    } catch (e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    
    super.onReady();

  }

}