
import 'package:nexobyte/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'detalle_entregas_leche_repository.dart';


class DetalleEntregasLecheController extends GetxController with StateMixin<DetalleEntregasLecheResponse> {

  // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
  final itemCtaCteLecheResumenDeLitrosMesItem = Get.arguments as CtaCteLecheResumenDeLitrosMesItem;

  final ScrollController scrollController = ScrollController();
  final DetalleEntregasLecheRepository _repository = Get.find<DetalleEntregasLecheRepository>();

  // * ----------------------------------------------------------------------------- La hago observable porque busco por páginas
  DetalleEntregasLecheResponse dataShowed = DetalleEntregasLecheResponse();

  //!------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    await obtenerEntregasDeLeche();
    EstadisticasDeUso.send("Ver detalle de entregas de leche");
    super.onReady();
  }

  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> obtenerEntregasDeLeche() async {
    try {

      DetalleEntregasLecheRequest request = DetalleEntregasLecheRequest(
        empresaId: itemCtaCteLecheResumenDeLitrosMesItem.empresaId,
        clienteId: itemCtaCteLecheResumenDeLitrosMesItem.clienteId,
        clienteTamboId: itemCtaCteLecheResumenDeLitrosMesItem.tamboId,
        fechaConsulta: DateTime(itemCtaCteLecheResumenDeLitrosMesItem.fecha.year, itemCtaCteLecheResumenDeLitrosMesItem.fecha.month, itemCtaCteLecheResumenDeLitrosMesItem.fecha.day),
        tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
      );

      change(null, status: RxStatus.loading());
      dataShowed = await _repository.obtenerEntregasDeLeche(request);
      change(dataShowed, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
  }

}