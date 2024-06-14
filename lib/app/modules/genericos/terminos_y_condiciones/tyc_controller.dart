import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'model/tyc_model.dart';
import 'tyc_provider.dart';

class TyCController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    obtenerTyC();
  }

  Rx<bool> onWillPop = false.obs;
  Rx<String> textoTyC = "".obs;

  final TyCProvider _repository = Get.find<TyCProvider>();

  //*----------------------------------------------------- obtenerTyC()
  Future<TyCResponse> obtenerTyC() async {

    TyCResponse response = TyCResponse();
    Get.dialog(const Center(child: kTCpi));
    try {
      response = await _repository.obtenerTyC();
      Get.back();
      textoTyC.value = response.terminosYCondiciones.toString();
    } 
    catch(e) {
      onWillPop.value = true;   //-- Si da error dejo volver a home
      Get.back();
      ApiExceptions.procesarError(e);
    }
    return response;
  }

  //*----------------------------------------------------- aceptarTyC()
  Future<AceptoTyCResponse> aceptarTyC() async {
    AceptoTyCResponse response = AceptoTyCResponse();
    Get.dialog(const Center(child: kTCpi));
    try {
      response = await _repository.aceptarTyC();
      Get.back();

      if (response.aceptoTyC)
      {
        Get.back();
      }
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    return response;
  }
}
