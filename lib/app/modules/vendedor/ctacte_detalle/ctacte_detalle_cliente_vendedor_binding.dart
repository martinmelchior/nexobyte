


import 'package:get/get.dart';

import 'ctacte_detalle_cliente_vendedor_controller.dart';
import 'ctacte_detalle_cliente_vendedor_provider.dart';
import 'ctacte_detalle_cliente_vendedor_repository.dart';

class CtaCteDetalleClienteVendedorBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut<CtaCteDetalleClienteVendedorController>(() => CtaCteDetalleClienteVendedorController());
    Get.lazyPut<CtaCteDetalleClienteVendedorRepository>(() => CtaCteDetalleClienteVendedorRepository());
    Get.lazyPut<CtaCteDetalleClienteVendedorProvider>(() => CtaCteDetalleClienteVendedorProvider());
      
  }

} 