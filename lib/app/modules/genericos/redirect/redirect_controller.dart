import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';


class RedirectController extends GetxController {

  @override
  void onReady() async {

    //-- ADD PDP
    if (PreferenciasDeUsuarioStorage.isFirstTime)
    {
      PreferenciasDeUsuarioStorage.tokenDeAcceso = '';
      PreferenciasDeUsuarioStorage.rol = '';
    }

    String _tokenDeAcceso = PreferenciasDeUsuarioStorage.tokenDeAcceso;
    String _rol = PreferenciasDeUsuarioStorage.rol.trim().toUpperCase();

    if ( (_tokenDeAcceso == '' && _rol == '') || 
         (_tokenDeAcceso == '' && _rol != '') || 
         (_tokenDeAcceso != '' && _rol == '') )
    {
      //! No TA - Si ROL --> GOTO LOGIN !!!
      //! Si TA - No ROL --> GOTO LOGIN !!!
      //!---------------------------------------------------------------------------------------------
      Get.offNamed(AppRoutes.rLogin);
    } 
    else if ( _tokenDeAcceso != '' && _rol != '' )
    {
      //! Si tengo TA y ROL -> SI DEBE CAMBIAR CONTRASEÑA REDIRIJO !!
      //!--------------------------------------------------------------------------------------------- TIENE QUE CAMBIAR LA CONTRASEÑA
      if (PreferenciasDeUsuarioStorage.cambiarPassword) 
      {
        Get.offNamed(AppRoutes.rPasswordChange);
      }
      else if (_tokenDeAcceso != '' && _rol == Roles.CLIENTES.toText() )
      {
        //!--------------------------------------------------------------------------------------------- Es CLIENTE de la EMPRESA
        Get.offNamed(AppRoutes.rHomeCliente);
      }
      else
      {
        //!---------------------------------------------------------------------------------------------- NO TIENE ROL asignado !!
        Get.offNamed(AppRoutes.rLogin);
      }
    }
    
    super.onReady();
  }

}