import 'package:get/get.dart';
import 'agenda_cbu_item_controller.dart';
import 'agenda_cbu_item_provider.dart';

class AgendaCbuItemBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AgendaCbuItemController>(() => AgendaCbuItemController());
    Get.lazyPut<AgendaCbuItemProvider>(() => AgendaCbuItemProvider());
  }

}