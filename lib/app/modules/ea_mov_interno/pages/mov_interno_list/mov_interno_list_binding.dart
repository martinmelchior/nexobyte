
import 'package:get/get.dart';

import 'mov_interno_list_controller.dart';
import 'mov_interno_list_provider.dart';

class MovInternoListBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<MovInternoListController>(() => MovInternoListController());
    Get.lazyPut<MovInternoListProvider>(() => MovInternoListProvider());
      
  }

} 