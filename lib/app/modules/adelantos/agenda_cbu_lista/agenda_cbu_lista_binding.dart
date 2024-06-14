

import 'package:get/get.dart';

import 'agenda_cbu_lista_controller.dart';
import 'agenda_cbu_lista_provider.dart';

class AgendaCbuListBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AgendaCbuListController>(() => AgendaCbuListController());
    Get.lazyPut<AgendaCbuListProvider>(() => AgendaCbuListProvider());
  }
}