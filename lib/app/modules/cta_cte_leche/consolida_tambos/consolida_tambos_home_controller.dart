import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'consolida_tambos_home_repository.dart';

class ConsolidaTambosController extends GetxController {
  final _repository = Get.find<ConsolidaTambosRepository>();

  Rx<CtaCteLecheResumenDeLitrosMesResponse> litrosMesTamboResponse = CtaCteLecheResumenDeLitrosMesResponse().obs;

  // * --------------------------------------------------------------------------- obtenerResumenListrosMesActual
  Future<void> obtenerResumenLitrosMesActual() async {
    Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
    try {
      CtaCteLecheResumenDeLitrosMesResponse response = await _repository.obtenerResumenLitrosMesActual();
      Get.back();

      //-- Sin el [] no estaba daba error !
      litrosMesTamboResponse.value.listaDeResumenDeLitrosItem = [];
      litrosMesTamboResponse.value.listaDeResumenDeLitrosItem.addAll(response.listaDeResumenDeLitrosItem);
      litrosMesTamboResponse.refresh();
    } catch (e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }
}
