import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'menu_contratista_provider.dart';

class MenuContratistaController extends GetxController with StateMixin<EAResourcesResponse> {

  final MenuContratistaProvider _provider = Get.find<MenuContratistaProvider>();

  late OrdenesLaboreosResumenDeContratistasItem itemResumenContratista; 
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
    itemResumenContratista = Get.arguments as OrdenesLaboreosResumenDeContratistasItem;
  
    //*--- Cargo entidad para obtener los recursos de EAs
    requestEARerources.empresaId = itemResumenContratista.empresaId;
    requestEARerources.gEconomicoId = itemResumenContratista.gEconomicoId;
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