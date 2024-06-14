

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ctacte_granaria_consolida_especie_repository.dart';

class CtaCteGranariaConsolidaEspecieController extends GetxController {

  final _repository = Get.find<CtaCteGranariaConsolidaEspecieRepository>();

  Rx<SaldosPorEspecieResponse> saldosPorEspecieResponse = SaldosPorEspecieResponse().obs;

  // * --------------------------------------------------------------------------- loadSaldosPorEspecie
  Future<void> loadSaldosPorEspecie() async { 

    Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
    try {
      SaldosPorEspecieResponse response = await _repository.loadSaldosPorEspecie();
      Get.back();

      //-- Sin el [] no estaba daba error !
      saldosPorEspecieResponse.value.listaDeSaldosPorEspecie = [];
      saldosPorEspecieResponse.value.listaDeSaldosPorEspecie.addAll(response.listaDeSaldosPorEspecie);
      saldosPorEspecieResponse.refresh();
      
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }

}