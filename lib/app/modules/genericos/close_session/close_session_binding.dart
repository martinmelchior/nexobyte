import 'package:get/get.dart';

import 'close_session_controller.dart';

class CloseSessionBinding implements Bindings {
  @override
  void dependencies() { 
    Get.lazyPut(() => CloseSessionController());
  }
}