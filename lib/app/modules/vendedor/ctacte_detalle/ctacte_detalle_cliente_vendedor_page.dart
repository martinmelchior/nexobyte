import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:money2/money2.dart';

import 'ctacte_detalle_cliente_vendedor_controller.dart';

// ignore: must_be_immutable
class CtaCteDetalleClienteVendedorPage extends GetView<CtaCteDetalleClienteVendedorController> {
  int registro = 0;

  DetalleCtaCteItem? dataItem;

  CtaCteDetalleClienteVendedorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        bottom: PreferredSize(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: ShowHeaderCtaCteResumen(ctaCteResumenDeSaldosItem: controller.itemResumenCtaCte),
            height: 120.0),
          preferredSize: const Size.fromHeight(110.0),
        ),
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: const Text("Detalle de Cta Cte", style: TextStyle(fontSize: 18.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
      ),
      body: controller.obx(
              (state) => Stack(children: [
                ListView.separated(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => Container(),
                  itemCount: state!.listaDetalleCtaCteItem!.length,
                  itemBuilder: (BuildContext context, int index) {
                    dataItem = state.listaDetalleCtaCteItem![index];
                    registro++;
                    return ShowCtaCteItem(
                        ctacteItem: dataItem!, registro: registro);
                  }),
                  Obx(() => Visibility(
                    visible: controller.loading.value && controller.request.pageNro > 1,
                        child: const Column(
                          children: [
                            Expanded(child: SizedBox()),
                            SizedBox(
                              width: double.infinity,
                              child: Center(child: kTLpi)),
                          ],
                        ),
                      )),
                  ]),
              onLoading: const MyProgressIndicactor(mensaje: 'Buscando datos de la cuenta\ncorriente de tu cliente asignado !'),
              onEmpty: const MyDataNotFoundMessage(),
              onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- SHOW HEADER
class ShowHeaderCtaCteResumen extends StatelessWidget {
  final CtaCteResumenDeSaldosItem ctaCteResumenDeSaldosItem;

  //-- ADD 2.2
  final CtaCteDetalleClienteVendedorController controller = Get.find<CtaCteDetalleClienteVendedorController>();

  ShowHeaderCtaCteResumen(
      {Key? key, required this.ctaCteResumenDeSaldosItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text( ctaCteResumenDeSaldosItem.empresa,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: kTAllLabelsColor)),
          const SizedBox(height: 8.0),
          Text(ctaCteResumenDeSaldosItem.cliente.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14.0, color: kTAllLabelsColor)),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  //-- ADD 2.2
                  Money.fromNumWithCurrency(ctaCteResumenDeSaldosItem.saldo, Constants.monedaAR).toString(),
                  style: TextStyle(
                      // shadows: (ctaCteResumenDeSaldosItem.saldo >= 0)
                      //     ? const [kTShadowImporteAFavor]
                      //     : const [kTShadowImporteEnContra],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: ctaCteResumenDeSaldosItem.saldo < 0
                          ? kTImporteEnContra
                          : kTImporteAFavor)),
              const SizedBox(width: 10.0),
              (ctaCteResumenDeSaldosItem.saldo < 0)
                  ? const Icon(Icons.arrow_downward,
                      color: kTImporteEnContra, size: 28)
                  : const Icon(Icons.arrow_upward,
                      color: kTImporteAFavor, size: 28),
            ],
          ),
        ],
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowCtaCteItem extends StatelessWidget {
  DetalleCtaCteItem ctacteItem;
  int registro;

  //!-- ADD 2.2
  final CtaCteDetalleClienteVendedorController controller = Get.find<CtaCteDetalleClienteVendedorController>();

  ShowCtaCteItem({
    Key? key,
    required this.ctacteItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat("dd-MM-yyyy").format(ctacteItem.fecha), style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //!-- ADD 3.6
                //*--------------------------------------------------------------------- boton VER PDF del comprobante
                Visibility(
                  visible:  ctacteItem.comprobanteImagenId != '' && ctacteItem.comprobanteImagenId != null,                            
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    child: GestureDetector(
                      child: Image.asset(Constants.kImgPDF, width: 40, height: 40),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.rVerComprobante, 
                                          arguments: DownloadComprobanteRequest(
                                              tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                              gEconomicoId: controller.itemResumenCtaCte.gEconomicoId,
                                              empresaId: controller.itemResumenCtaCte.empresaId,
                                              guidComprobante: ctacteItem.comprobanteImagenId,
                                              ctaCteId: ctacteItem.ctaCteId
                                            )
                                          );
                      },
                    ),
                  ),
                ),


                Expanded(
                  flex: ctacteItem.olId > 0 ? 10 : 1,
                  child: Text('${ctacteItem.detalle}',style: const TextStyle(fontSize: 14.0, color: Colors.black54))),
              ],
            ),
            const SizedBox(height: 5.0),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          Money.fromNumWithCurrency(
                                  ctacteItem.importe, Constants.monedaAR)
                              .toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: ctacteItem.importe < 0
                                  ? Colors.red
                                  : kTImporteAFavor)),
                    ),
                    Text(
                        Money.fromNumWithCurrency(
                                ctacteItem.saldo, Constants.monedaAR)
                            .toString(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: ctacteItem.saldo < 0
                                ? Colors.red
                                : kTImporteAFavor))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
