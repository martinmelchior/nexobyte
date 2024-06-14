

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/feedback/model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'enviar_feedback_provider.dart';

class EnviarFeedbackController extends GetxController {

  EnviarFeedbackController();

  EnviarFeedbackProvider apiProvider = Get.find<EnviarFeedbackProvider>();

  final TextEditingController mensajeController = TextEditingController();
  String tipo = '';
  
  // * ----------------------------------------------------------------------------- enviarFeedback
  Future<EnviarFeedbackResponse> enviarFeedback() async {
    EnviarFeedbackResponse response = EnviarFeedbackResponse();
    Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
    try {
      EnviarFeedbackRequest req = EnviarFeedbackRequest(
        tipo: tipo,
        mensaje: mensajeController.value.text
      );
      response = await apiProvider.enviarFeedback(req);
      Get.back();
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    finally {
      Get.back();
    }
    return response;
  }
}