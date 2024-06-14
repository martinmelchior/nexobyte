

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/login_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'login_repository.dart';

class LoginController extends GetxController {

  LoginController();

  final _apiRequest = LoginRequest();
  final LoginRepository _repository = Get.find<LoginRepository>();

  var tapCount = 0.obs;

  // * ---------------------------------------------------- EMAIL 
  set email(String value) { _apiRequest.email = value; }
  String get email => _apiRequest.email ?? '';


  // * ---------------------------------------------------- PASSWORD
  set password(String value) { _apiRequest.password = value; }
  String get password => _apiRequest.email ?? '';

  
  // * ---------------------------------------------------- NOS CONECTAMOS A LA API PARA INTENTAR LOGUEAR AL USUARIO 
  Future<LoginResponse> autenticar() async { 

    LoginResponse response = LoginResponse();
    Get.dialog(const Center(child: kTCpi));
    try {
      response = await _repository.autenticar(_apiRequest);
      Get.back();

      //!--- UNA VEZ LOGUEADO POR PRIMERA VEZ DEJA DE SER FirstTime
      PreferenciasDeUsuarioStorage.isFirstTime = false;

      // * GUARDAMOS LAS PREFERENCIAS DEL USUSARIO + TA + TR
      PreferenciasDeUsuarioStorage.saveData(response.toJson());

      Get.offNamed(AppRoutes.rRedirect);
     
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }

    return response;
  }

 

}