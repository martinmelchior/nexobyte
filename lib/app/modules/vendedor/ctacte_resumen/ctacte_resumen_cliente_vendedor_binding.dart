

import 'package:get/get.dart';
import 'ctacte_resumen_cliente_vendedor_controller.dart';
import 'ctacte_resumen_cliente_vendedor_provider.dart';
import 'ctacte_resumen_cliente_vendedor_repository.dart';

class CtaCteResumenDeSaldosClientesVendedorBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CtaCteResumenDeSaldosClientesVendedorController>(() => CtaCteResumenDeSaldosClientesVendedorController());
    Get.lazyPut<CtaCteResumenDeSaldosClientesVendedorRepository>(() => CtaCteResumenDeSaldosClientesVendedorRepository());
    Get.lazyPut<CtaCteResumenDeSaldosClientesVendedorProvider>(() => CtaCteResumenDeSaldosClientesVendedorProvider());
      
  }

} 
  