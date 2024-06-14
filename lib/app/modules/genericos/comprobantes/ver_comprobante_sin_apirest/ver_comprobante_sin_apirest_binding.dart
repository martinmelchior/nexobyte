import 'package:get/get.dart';

import 'ver_comprobante_sin_apirest_controller.dart';
import 'ver_comprobante_sin_apirest_provider.dart';

class VerComprobanteSinApiRestBinding implements Bindings {

  @override
  void dependencies() {

    Get.lazyPut<VerComprobanteSinApiRestController>(() => VerComprobanteSinApiRestController());
    Get.lazyPut<VerComprobanteSinApiRestProvider>(() => VerComprobanteSinApiRestProvider());

  }

}