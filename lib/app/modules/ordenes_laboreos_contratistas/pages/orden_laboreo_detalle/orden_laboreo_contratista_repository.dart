

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'orden_laboreo_contratista_provider.dart';

class OrdenLaboreoContratistaDetalleRepository {

  OrdenLaboreoContratistaDetalleProvider apiProvider = Get.find<OrdenLaboreoContratistaDetalleProvider>();

  Future<ObtenerOrdenDeLaboreoContratistaDetalleResponse> obtenerOrdenDeLaboreoDetalle(ObtenerOrdenDeLaboreoContratistaDetalleRequest req) async {
    return apiProvider.obtenerOrdenDeLaboreoDetalle(req);
  }

}