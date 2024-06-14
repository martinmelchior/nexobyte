
import 'package:get/get.dart';
import 'find_articulos_controller.dart';
import 'find_articulos_provider.dart';

class FindArticulosBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<FindArticulosController>(() => FindArticulosController());
    Get.lazyPut<FindArticulosProvider>(() => FindArticulosProvider());
      
  }

} 