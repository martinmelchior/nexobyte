import 'package:get/get.dart';

import 'ctacte_resumen_xls_controller.dart';
import 'ctacte_resumen_xls_provider.dart';

class CtaCteResumenXlsBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<CtaCteResumenXlsController>(() => CtaCteResumenXlsController());
    Get.lazyPut<CtaCteResumenXlsProvider>(() => CtaCteResumenXlsProvider());
  }
}