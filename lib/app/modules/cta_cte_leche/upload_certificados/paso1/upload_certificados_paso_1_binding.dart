import 'package:get/get.dart';

import 'upload_certificados_paso_1_controller.dart';
import 'upload_certificados_paso_1_provider.dart';

class UploadCertificadosPaso1Binding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<UploadCertificadosPaso1Controller>(() => UploadCertificadosPaso1Controller());
    Get.lazyPut<UploadCertificadosPaso1Provider>(() => UploadCertificadosPaso1Provider());
  }
  
}