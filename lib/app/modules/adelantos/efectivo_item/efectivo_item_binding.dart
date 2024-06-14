import 'package:get/get.dart';
import 'efectivo_item_controller.dart';
import 'efectivo_item_provider.dart';

class EfectivoItemBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<EfectivoItemController>(() => EfectivoItemController());
    Get.lazyPut<EfectivoItemProvider>(() => EfectivoItemProvider());
  }

}