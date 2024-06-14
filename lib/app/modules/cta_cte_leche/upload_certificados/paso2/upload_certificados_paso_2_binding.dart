

import 'package:get/get.dart';

import 'upload_certificados_paso_2_controller.dart';
import 'upload_certificados_paso_2_provider.dart';

class UploadCertificadosPaso2Binding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<UploadCertificadosPaso2Controller>(() => UploadCertificadosPaso2Controller());
    Get.lazyPut<UploadCertificadosPaso2Provider>(() => UploadCertificadosPaso2Provider());
  }
}