

import 'package:nexobyte/app/utils/utils.dart';
import 'package:get/get.dart';

class CtaCteLecheResumenController extends GetxController {

  CtaCteLecheResumenController();

  @override
  void onInit() {
    EstadisticasDeUso.send("Resumen de Tambos");
    super.onInit();
    
  }
}