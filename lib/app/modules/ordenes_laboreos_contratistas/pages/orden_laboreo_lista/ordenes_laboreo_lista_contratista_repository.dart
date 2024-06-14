

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';

import 'ordenes_laboreo_lista_contratista_provider.dart';

class OrdenesLaboreoContratistaRepository {

  OrdenesLaboreoContratistaProvider apiProvider = Get.find<OrdenesLaboreoContratistaProvider>();

  Future<OrdenesLaboreosContratistaResponse> obtenerOrdenesLaboreosContratista(OrdenesLaboreosContratistaRequest request) async {
    return apiProvider.obtenerOrdenesLaboreosContratista(request);
  }

}