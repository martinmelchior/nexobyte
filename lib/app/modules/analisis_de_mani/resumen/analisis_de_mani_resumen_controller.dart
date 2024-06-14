


import 'package:get/get.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import '../model/analisis_de_mani_model.dart';
import 'analisis_de_mani_resumen_provider.dart';


class AnalisisDeManiResumenController extends GetxController with StateMixin<ResumenAnalisisItemResponse> {

  final AnalisisDeManiResumenProvider _provider = Get.find<AnalisisDeManiResumenProvider>();

  AnalisisDeManiResumenController();
 
  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerResumenDeCerrados();
    super.onReady();
  }


  // * ----------------------------------------------------------------------------- obtenerResumenDeSaldosCC
  //-- ADD 2.2
  Future<ResumenAnalisisItemResponse> obtenerResumenDeCerrados() async {
    ResumenAnalisisItemResponse response = ResumenAnalisisItemResponse(listaResumenAnalisisItem: []);
    try {
      response = await _provider.obtenerResumenDeAnalisis();
      if (response.listaResumenAnalisisItem.isEmpty)
      {
        change(null, status: RxStatus.empty());
      }
      else
      {
        change(response, status: RxStatus.success());
      }
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}