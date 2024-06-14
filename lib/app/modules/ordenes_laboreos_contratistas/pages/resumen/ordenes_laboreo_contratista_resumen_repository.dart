

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'ordenes_laboreo_contratista_resumen_provider.dart';



class OrdenesLaboreosResumenDeContratistaRepository {

  OrdenesLaboreosResumenDeContratistaProvider apiProvider = Get.find<OrdenesLaboreosResumenDeContratistaProvider>();

  Future<OrdenesLaboreosResumenDeContratistaResponse> obtenerResumenContratista() async {
    return apiProvider.obtenerResumenContratista();
  }

}