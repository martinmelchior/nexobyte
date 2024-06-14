
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:get/get.dart';

import 'upload_certificados_paso_1_provider.dart';

class UploadCertificadosPaso1Controller extends GetxController {

  UploadCertificadosPaso1Controller();

  final _provider = Get.find<UploadCertificadosPaso1Provider>();
  late CtaCteLecheResumenDeLitrosMesItem item;

  Rx<bool> rxTieneSubidaPendientes = false.obs;

  //*------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    item = Get.arguments as CtaCteLecheResumenDeLitrosMesItem;
    super.onInit();
  }

  //*------------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    rxTieneSubidaPendientes.value = await _provider.subidasPendientes(item);
    super.onReady();
  }
}