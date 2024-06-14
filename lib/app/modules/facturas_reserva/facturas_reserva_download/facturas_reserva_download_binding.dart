import 'package:get/get.dart';
import 'facturas_reserva_download_controller.dart';
import 'facturas_reserva_download_provider.dart';

class FacturasReservaDownloadBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<FacturasReservaDownloadController>(() => FacturasReservaDownloadController());
    Get.lazyPut<FacturasReservaDownloadProvider>(() => FacturasReservaDownloadProvider());
  }

}