

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/password_recovery_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'password_recovery_repository.dart';

class PasswordRecoveryController extends GetxController {

  PasswordRecoveryController();

  final PasswordRecoveryRepository _repository = Get.find<PasswordRecoveryRepository>();
  final _source = PasswordRecoveryRequest();

  // * ---------------------------------------------------- EMAIL 
  set email(String value) { _source.email = value; }
  String get email => _source.email ?? '';

  // * ---------------------------------------------------- NOS CONECTAMOS A LA API PARA INICIAR PROCESO DE RECUPERO DE CONTRASEÑA
  Future<PasswordRecoveryResponse> recuperar() async { 

    PasswordRecoveryResponse response = PasswordRecoveryResponse();
    Get.dialog(const Center(child: kTCpi));
    
    try {
      response = await _repository.recuperar(_source);
      
      Get.dialog(
        AlertDialog(
          backgroundColor: kTLightPrimaryColor1,
          title: const Text('Casi listo'),
          titleTextStyle: const TextStyle(fontSize: 22.0, color: kErrorBackColor),
          content: Text(response.mensaje),
          actions: [
            TextButton(
              style: kTButtonStyle,
              child: const Text("Cerrar"),
              onPressed: () {
                Get.toNamed(AppRoutes.rLogin);
              }
            )
          ]
        )
      );
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    return response;
  }
 

}