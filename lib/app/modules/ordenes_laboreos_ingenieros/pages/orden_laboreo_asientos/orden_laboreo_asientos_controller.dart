

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';

class OrdenLaboreoAsientosController extends GetxController with StateMixin<ObtenerAsientosContablesOLResponse> {

  OrdenLaboreoAsientosController();

  Rx<ObtenerAsientosContablesOLResponse> asientosContablesResponse = ObtenerAsientosContablesOLResponse().obs;

  @override
  void onInit() {
    var data = Get.arguments;
    if (data != null)
    {
      asientosContablesResponse.value = data as ObtenerAsientosContablesOLResponse;   
    }
    change(null, status: RxStatus.success());
    super.onInit();
  }
}