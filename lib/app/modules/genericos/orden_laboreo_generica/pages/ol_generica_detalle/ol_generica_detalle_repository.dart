

import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/model/ol_generica_model.dart';
import 'ol_generica_detalle_provider.dart';


class OrdenLaboreoGenericaDetalleRepository {

  OrdenLaboreoGenericaDetalleProvider apiProvider = Get.find<OrdenLaboreoGenericaDetalleProvider>();

  Future<OLGenericaDetalleResponse> obtenerOLGenericaDetalle(OLGenericaDetalleRequest req) async {
    return apiProvider.obtenerOLGenericaDetalle(req);
  }

}