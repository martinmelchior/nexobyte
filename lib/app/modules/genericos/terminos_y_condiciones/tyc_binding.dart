import 'package:get/get.dart';
import 'package:nexobyte/app/modules/genericos/terminos_y_condiciones/tyc_provider.dart';

import 'tyc_controller.dart';

class TyCBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => TyCController());
    Get.lazyPut(() => TyCProvider());
  }

}