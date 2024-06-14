

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/password_change_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'password_change_repository.dart';

class PasswordChangeController extends GetxController {

  PasswordChangeController();

  final PasswordChangeRepository _repository = Get.find<PasswordChangeRepository>();

  //* NOS CONECTAMOS A LA API PARA CAMBIAR LA CONTRASEÑA
  Future<void> cambiarPassword(String password) async { 

    PasswordChangeResponse response;
    Get.dialog(const Center(child: kTCpi));
    try {
      response = await _repository.cambiarPassword(PreferenciasDeUsuarioStorage.tokenDeAcceso, PreferenciasDeUsuarioStorage.tokenDeRefresco, password);
      Get.back();

      //* GUARDAMOS LAS PREFERENCIAS DEL USUSARIO
      //* Este metodo tiene que avisarme que la cambio ok para pisar cambiarPassword = false en el mobile
      PreferenciasDeUsuarioStorage.saveData(response.toJson());
      
      //print("cambiarPassword --> ${PreferenciasDeUsuarioStorage.cambiarPassword}");

      Get.offNamed(AppRoutes.rRedirect);
      
    } 
    catch (e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }

 

}