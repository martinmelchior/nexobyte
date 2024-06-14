import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'liquidaciones_lista_provider.dart';
import 'models/liquidaciones_model.dart';

class LiquidacionesListaController extends GetxController with StateMixin<LiquidacionLecheResponse> {

  final ScrollController scrollController = ScrollController();
  final LiquidacionesListaProvider apiProvider = Get.find<LiquidacionesListaProvider>();
  LiquidacionLecheResponse response = LiquidacionLecheResponse();
  
  // * --------- Paso entidad de resumen para tener todos los datos
  late CtaCteLecheResumenDeLitrosMesItem request;

  @override
  void onInit() {
    request = Get.arguments as CtaCteLecheResumenDeLitrosMesItem;
    super.onInit();
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerLiquidacionesLeche();
    super.onReady();
  }

 
  // * ----------------------------------------------------------------------------- obtenerLiquidacionesLeche
  Future<LiquidacionLecheResponse> obtenerLiquidacionesLeche() async {
    try {
      change(null, status: RxStatus.loading());
      response = await apiProvider.obtenerLiquidacionesLeche(request);
      EstadisticasDeUso.send("Consulta listado de LIQUIDACIONES LECHE");
      change(response, status: response.listaDeLiquidaciones.isEmpty ? RxStatus.empty() : RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}