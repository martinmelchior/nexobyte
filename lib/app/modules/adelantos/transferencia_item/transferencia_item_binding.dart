import 'package:get/get.dart';
import 'transferencia_item_controller.dart';
import 'transferencia_item_provider.dart';

class TransferenciaItemBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<TransferenciaItemController>(() => TransferenciaItemController());
    Get.lazyPut<TransferenciaItemProvider>(() => TransferenciaItemProvider());
  }

}