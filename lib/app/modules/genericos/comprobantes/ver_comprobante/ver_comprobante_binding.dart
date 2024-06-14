import 'package:get/get.dart';

import 'ver_comprobante_controller.dart';
import 'ver_comprobante_provider.dart';

class VerComprobanteBinding implements Bindings {

  @override
  void dependencies() {

    Get.lazyPut<VerComprobanteController>(() => VerComprobanteController());
    Get.lazyPut<VerComprobanteProvider>(() => VerComprobanteProvider());

  }

}