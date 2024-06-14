import 'package:get/get.dart';
import 'ctacte_granaria_resumen_xls_controller.dart';
import 'ctacte_granaria_resumen_xls_provider.dart';


class CtaCteGranariaResumenXlsBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<CtaCteGranariaResumenXlsController>(() => CtaCteGranariaResumenXlsController());
    Get.lazyPut<CtaCteGranariaResumenXlsProvider>(() => CtaCteGranariaResumenXlsProvider());
  }
}