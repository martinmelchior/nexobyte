import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'menu_ingenieros_provider.dart';

class MenuIngenierosController extends GetxController with StateMixin<EAResourcesResponse> {

  final MenuIngenieroProvider _provider = Get.find<MenuIngenieroProvider>();

  late OrdenesLaboreosResumenDeIngenieroItem itemResumen; 
  EAResourcesRequest requestEARerources = EAResourcesRequest();
  EAResourcesResponse recursosEA = EAResourcesResponse();

  @override
  void onReady() async {
    super.onReady();
    await obtenerRecursosEA();
  }

  @override
  void onInit() async {
    super.onInit();

    //*--- Aca ya tengo los datos de la empresa/geconomico    
    itemResumen = Get.arguments as OrdenesLaboreosResumenDeIngenieroItem;
    
    //*--- Cargo entidad para obtener los recursos de EAs
    requestEARerources.empresaId = itemResumen.empresaId;
    requestEARerources.gEconomicoId = itemResumen.gEconomicoId;
  }



  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> obtenerRecursosEA() async {
    Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
    try {
      recursosEA = await _provider.obtenerRecursosEA(requestEARerources);
      Get.back();
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    
  }
}