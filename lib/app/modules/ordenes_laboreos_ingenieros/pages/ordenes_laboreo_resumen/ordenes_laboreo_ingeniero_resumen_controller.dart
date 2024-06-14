

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ordenes_laboreo_ingeniero_resumen_provider.dart';


class OrdenesLaboreosResumenDeIngenieroController extends GetxController with StateMixin<OrdenesLaboreosResumenDeIngenieroResponse> {

  OrdenesLaboreosResumenDeIngenieroProvider apiProvider = Get.find<OrdenesLaboreosResumenDeIngenieroProvider>();
  late EAResourcesRequest requestResourcesEA;

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerResumenIngeniero();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenIngeniero
  Future<OrdenesLaboreosResumenDeIngenieroResponse> obtenerResumenIngeniero() async {
    OrdenesLaboreosResumenDeIngenieroResponse response = OrdenesLaboreosResumenDeIngenieroResponse(listaResumenDeIngenierosItem: []);
    try {
      response = await apiProvider.obtenerResumenIngeniero();
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}