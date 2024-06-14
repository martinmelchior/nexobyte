

import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'ctacte_resumen_cliente_vendedor_repository.dart';

class CtaCteResumenDeSaldosClientesVendedorController extends GetxController with StateMixin<CtaCteResumenDeSaldosResponse> {

  final CtaCteResumenDeSaldosClientesVendedorRepository _repository = Get.find<CtaCteResumenDeSaldosClientesVendedorRepository>();

  final filtrando = false.obs;
  List<String> kListaAbecedario  = ['A','B','C','D','E','F','G','H','I','J','K','L','LL','M','N','Ñ','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

  CtaCteResumenDeSaldosResponse response = CtaCteResumenDeSaldosResponse(listaDeSaldosDeCtasCtes: []);
  CtaCteResumenDeSaldosResponse responseAll = CtaCteResumenDeSaldosResponse(listaDeSaldosDeCtasCtes: []);

  CtaCteResumenDeSaldosClientesVendedorController();
 
  //*----------------------------------------------------------------------------- Filtro lista de clientes
  void filtrarClientes(bool seleccionado, String value) {
    change(null, status: RxStatus.loading());
    response.listaDeSaldosDeCtasCtes.clear();
    if (seleccionado)
    {
      //*-- Selecciono por la letra
      response.listaDeSaldosDeCtasCtes.assignAll(responseAll.listaDeSaldosDeCtasCtes.where((element) => element.cliente.toUpperCase().startsWith(value.toUpperCase())).toList());
      filtrando.value = true;
    }
    else
    {
      //*-- limpio seleccion
      response.listaDeSaldosDeCtasCtes.assignAll(responseAll.listaDeSaldosDeCtasCtes);
      filtrando.value = false;
    }
    change(response, status: RxStatus.success());
  }


  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    await obtenerResumenDeSaldosCCClientesVendedor();
    super.onReady();
  }

  // * ----------------------------------------------------------------------------- obtenerResumenDeSaldosCC
  Future<CtaCteResumenDeSaldosResponse> obtenerResumenDeSaldosCCClientesVendedor() async {
    try {
      response = await _repository.obtenerResumenDeSaldosCCClientesVendedor();
      responseAll.listaDeSaldosDeCtasCtes.clear();
      responseAll.listaDeSaldosDeCtasCtes.assignAll(response.listaDeSaldosDeCtasCtes);
      change(response, status: RxStatus.success());
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
    return response;
  }

  
}