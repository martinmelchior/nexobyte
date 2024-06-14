
import 'package:get/get.dart';
import 'analisis_item_controller.dart';
import 'analisis_item_provider.dart';

class AnalisisItemBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AnalisisItemController>(() => AnalisisItemController());
    Get.lazyPut<AnalisisItemProvider>(() => AnalisisItemProvider());
  }

} 