import 'package:get/get.dart';
import 'comp_pendientes_download_controller.dart';
import 'comp_pendientes_download_provider.dart';

class CompPendientesDownloadBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CompPendientesDownloadController>(() => CompPendientesDownloadController());
    Get.lazyPut<CompPendientesDownloadProvider>(() => CompPendientesDownloadProvider());
  }

}