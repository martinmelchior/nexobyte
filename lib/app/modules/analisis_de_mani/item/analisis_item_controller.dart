
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import '../model/analisis_de_mani_model.dart';
import 'analisis_item_provider.dart';

class AnalisisItemController extends GetxController with StateMixin<AnalisisDeMani> {

  final ScrollController scrollController = ScrollController();
  final AnalisisItemProvider _provider = Get.find<AnalisisItemProvider>();

  Rx<bool> loading = false.obs;
  bool allLoaded = false;

  AnalisisDeMani dataShowed = AnalisisDeMani();
  int analisisId = 0;
  String gEconomicoId = '';
  String empresaId = '';
  
  //!------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    super.onInit();
    analisisId = Get.arguments["analisisId"];       // * lo recibo como parametro
    gEconomicoId = Get.arguments["gEconomicoId"];   // * lo recibo como parametro
    empresaId = Get.arguments["empresaId"];         // * lo recibo como parametro
  }

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerAnalisisDeManiItem();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------------------------------------- obtenerAnalisisDeManiItem
  Future<void> obtenerAnalisisDeManiItem() async {
    try {
      change(null, status: RxStatus.loading());
      dataShowed = await _provider.obtenerAnalisisDeManiItem(gEconomicoId, empresaId, analisisId);
      change(dataShowed, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
  }
  
     

  
}