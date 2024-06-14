import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';

class CloseSessionController extends GetxController {

  @override
  void onReady() {

    //-- Limpio valor de las preferences para ir a login!!!
    PreferenciasDeUsuarioStorage.tokenDeAcceso = "";
    PreferenciasDeUsuarioStorage.tokenDeRefresco = "";
    
    //-- Deberia redirigir a login
    Get.offAllNamed(AppRoutes.rRedirect);
    
    super.onReady();
  }

  
}