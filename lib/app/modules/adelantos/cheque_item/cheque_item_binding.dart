import 'package:get/get.dart';
import 'cheque_item_controller.dart';
import 'cheque_item_provider.dart';

class ChequeItemBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ChequeItemController>(() => ChequeItemController());
    Get.lazyPut<ChequeItemProvider>(() => ChequeItemProvider());
  }

}