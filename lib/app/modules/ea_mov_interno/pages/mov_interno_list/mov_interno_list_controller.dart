

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'mov_interno_list_provider.dart';


class MovInternoListController extends GetxController with StateMixin<MovimientoResponse> {

  int _contratistaId = -1;
  int _ingenieroId = -1;
  EAResourcesRequest paramReqEAResources = EAResourcesRequest();
  EAResourcesResponse eaResources = EAResourcesResponse();
  MovInternoListProvider apiProvider = Get.find<MovInternoListProvider>();
  MovimientoResponse response = MovimientoResponse();

  @override
  void onInit() {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    paramReqEAResources = Get.arguments["requestEARerources"] as EAResourcesRequest;
    eaResources = Get.arguments["eaResources"] as EAResourcesResponse;
    _contratistaId = Get.arguments["contratistaId"] ?? -1;
    _ingenieroId = Get.arguments["ingenieroId"] ?? -1;
    super.onInit();
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerMovimientosInternos();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- anularMovimientosInternos
  Future<MovimientoResponse> anularMovimientoInterno(MovimientoInterno movimientoInterno, BuildContext context) async {
    try {
      Get.back();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const  Dialog(
            backgroundColor: Colors.white,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Aguarda, estamos anulando tu Movimiento Interno", textAlign: TextAlign.center),
                  SizedBox(height: 15),
                  kTCpi,
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
      
      MovimientoRequest req = MovimientoRequest(empresaId: paramReqEAResources.empresaId, gEconomicoId: paramReqEAResources.gEconomicoId);
      req.movInterno = movimientoInterno;
      response = await apiProvider.anularMovimientoInterno(req);
      Get.back();
      
      Get.snackbar(
        "LISTO",
        "El Movimiento Interno de ${numberFormat.format(movimientoInterno.cantidad)} Kgs fue ANULADO !!",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 0.0,
        margin: const EdgeInsets.all(0),
        duration: const Duration(seconds: 5),
      );
      
      await obtenerMovimientosInternos();

    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
    return response;
  }

  // * ----------------------------------------------------------------------------- obtenerResumenIngeniero
  Future<MovimientoResponse> obtenerMovimientosInternos() async {
    try {
      MovimientoRequest req = MovimientoRequest(
        empresaId: paramReqEAResources.empresaId, 
        gEconomicoId: paramReqEAResources.gEconomicoId,
        contratistaId: _contratistaId,
        ingenieroId: _ingenieroId,
      );
      change(null, status: RxStatus.loading());
      response = await apiProvider.obtenerMovimientosInternos(req);
      change(response, status: response.movimientos.isEmpty ? RxStatus.empty() : RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}