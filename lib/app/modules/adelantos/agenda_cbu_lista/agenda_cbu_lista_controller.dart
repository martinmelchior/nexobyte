
import 'package:nexobyte/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/manager_api_exceptions.dart';
import '../model/adelantos_model.dart';
import 'agenda_cbu_lista_provider.dart';


class AgendaCbuListController extends GetxController with StateMixin<AgendaCbuResponse> {

  final AgendaCbuListProvider apiProvider = Get.find<AgendaCbuListProvider>();
  AgendaCbuResponse response = AgendaCbuResponse();
  String tipoDeCuenta = TipoDeCuenta.todas.toValueText;

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerAgendaCbu();
    EstadisticasDeUso.send("Ver Agenda CBU/ALIAS");
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    tipoDeCuenta =  Get.arguments["tipoDeCuenta"];
    super.onInit();
  }
 
  String getSubTitulo() {
    String titulo = "TODAS LAS CUENTAS";
    if (tipoDeCuenta == TipoDeCuenta.cuentaspropias.toValueText) { titulo = "CUENTAS PROPIAS"; }
    else if (tipoDeCuenta == TipoDeCuenta.otrascuentas.toValueText) { titulo = "OTRAS CUENTAS"; }
    return titulo;
  }


  // * ----------------------------------------------------------------------------- obtenerResumenIngeniero
  Future<AgendaCbuResponse> obtenerAgendaCbu() async {
    try {
      change(null, status: RxStatus.loading());
      response = await apiProvider.obtenerAgendaCbu(tipoDeCuenta);
      change(response, status: response.listaDeCbuAlias.isEmpty 
        ? RxStatus.empty() 
        : RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  // * ----------------------------------------------------------------------------- Eliminar CBU / Alias
  Future<bool> eliminarAgendaCbu(AgendaCbu _agendaCbu, BuildContext _context) async {
    try {
      Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
      await apiProvider.eliminarAgendaCbu(_agendaCbu.id);
      Get.back();
      
      Get.snackbar(
        "LISTO",
        "Cbu/Alias  ${_agendaCbu.descripcion}  ELIMINADO !!",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 0.0,
        margin: const EdgeInsets.all(0),
        duration: const Duration(seconds: 3),
      );
      
      if (Get.isSnackbarOpen) Get.back();

      await obtenerAgendaCbu();

    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    return true;
  }
}