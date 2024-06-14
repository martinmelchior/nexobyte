
import 'package:get/get.dart';
import 'mov_interno_controller.dart';
import 'mov_interno_provider.dart';

class MovInternoItemBinding implements Bindings {

  @override
  void dependencies() {
      Get.lazyPut<MovInternoItemController>(() => MovInternoItemController());
      Get.lazyPut<MovInternoItemProvider>(() => MovInternoItemProvider());
    }

}