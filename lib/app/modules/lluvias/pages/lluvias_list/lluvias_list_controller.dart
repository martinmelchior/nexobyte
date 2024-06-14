import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/lluvias/model/lluvias_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'lluvias_list_provider.dart';

class LluviasListController extends GetxController with StateMixin<LluviasResponse> {

  final LluviasListProvider apiProvider = Get.find<LluviasListProvider>();
  LluviasResponse response = LluviasResponse();
  
  
  // * --------- Paso entidad de resumen para tener todos los datos
  late OrdenesLaboreosResumenDeIngenieroItem request;
  late EAResourcesResponse recursosEA;

  @override
  void onInit() {
    request = Get.arguments["itemResumenIngeniero"] as OrdenesLaboreosResumenDeIngenieroItem;
    recursosEA = Get.arguments["recursosEA"] as EAResourcesResponse;
    super.onInit();
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerLluvias();
    super.onReady();
  }

 
  // * ----------------------------------------------------------------------------- obtenerResumenIngeniero
  Future<LluviasResponse> obtenerLluvias() async {
    try {
      LluviasRequest req = LluviasRequest(
        empresaId: request.empresaId, 
        gEconomicoId: request.gEconomicoId,
      );
      change(null, status: RxStatus.loading());
      response = await apiProvider.obtenerLluvias(req);
      change(response, status: response.lluvias.isEmpty ? RxStatus.empty() : RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  // * ----------------------------------------------------------------------------- Eliminar LLuvia
  Future<bool> eliminarLluvia(Lluvia _lluvia, BuildContext _context) async {
    try {
      Get.back();

      showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            backgroundColor: Colors.white,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Aguarda, estamos eliminando la lluvia!", textAlign: TextAlign.center),
                  SizedBox(height: 15),
                  kTCpi,
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
      
      EliminarLluviaRequest req = EliminarLluviaRequest(
        empresaId: request.empresaId, 
        gEconomicoId: request.gEconomicoId,
        lluvia: _lluvia);

      await apiProvider.eliminarLluvias(req);
      Get.back();
      
      Get.snackbar(
        "LISTO",
        "La lluvia fue ELIMINADA !!",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 0.0,
        margin: const EdgeInsets.all(0),
        duration: const Duration(seconds: 5),
      );
      
      await obtenerLluvias();

    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    return true;
  }
}