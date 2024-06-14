import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'ordenes_laboreo_contratista_resumen_repository.dart';


class OrdenesLaboreosResumenDeContratistaController extends GetxController with StateMixin<OrdenesLaboreosResumenDeContratistaResponse> {

  final OrdenesLaboreosResumenDeContratistaRepository _repository = Get.find<OrdenesLaboreosResumenDeContratistaRepository>();
  
  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerResumenContratista();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenContratista
  Future<OrdenesLaboreosResumenDeContratistaResponse> obtenerResumenContratista() async {
    OrdenesLaboreosResumenDeContratistaResponse response = OrdenesLaboreosResumenDeContratistaResponse(listaResumenDeContratistasItem: []);
    try {
      response = await _repository.obtenerResumenContratista();
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}