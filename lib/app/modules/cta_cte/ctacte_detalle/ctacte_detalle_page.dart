import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/model.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/model/ol_generica_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/cta_cte_detalle_model.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:money2/money2.dart';

import 'ctacte_detalle_controller.dart';

// ignore: must_be_immutable
class CtaCteDetallePage extends GetView<CtaCteDetalleController> {
  int registro = 0;

  DetalleCtaCteItem? dataItem;

  CtaCteDetallePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //-- ADD 2.2
    String _titulo = "Movimientos";
    if (controller.enDolares) _titulo += " (en dolares)";

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        bottom: PreferredSize(
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: ShowHeaderCtaCteResumen(ctaCteResumenDeSaldosItem: controller.itemResumenCtaCte),
              height: 120.0),
          preferredSize: const Size.fromHeight(100.0),
        ),
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: Text(_titulo, style: const TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
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
                    return ShowCtaCteItem(ctacteItem: dataItem!, registro: registro);
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
              onLoading: const MyProgressIndicactor(mensaje: 'Buscando datos de la\ncuenta corriente !'),
              onEmpty: const MyDataNotFoundMessage(),
              onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- SHOW HEADER
class ShowHeaderCtaCteResumen extends StatelessWidget {

  //-- ADD 2.2
  final CtaCteDetalleController controller = Get.find<CtaCteDetalleController>();

  final CtaCteResumenDeSaldosItem ctaCteResumenDeSaldosItem;

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
              //!-- Add 2.7
              Obx(() => Visibility(
                  visible: controller.showResumneOls.value,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.rResumenOperarioOls, arguments: { 'itemResumenCtaCte': controller.itemResumenCtaCte });
                              },
                              child: const Chip(
                                elevation: 10,
                                padding: EdgeInsets.all(8),
                                backgroundColor: kTLightPrimaryColor,
                                shadowColor: Colors.black,
                                label: Text('Ver Resumen', style: TextStyle(fontSize: 12, color: Colors.white),
                                ), //Text
                              ),
                            ), //
                          ],
                      ),
                    ),
                  )
                )
              ),
              Text(
                  //-- ADD 2.2
                  Money.fromNumWithCurrency(ctaCteResumenDeSaldosItem.saldo, controller.enDolares ? Constants.monedaUSD : Constants.monedaAR).toString(),
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

  //!-- ADD 2.2
  final CtaCteDetalleController controller = Get.find<CtaCteDetalleController>();

  DetalleCtaCteItem ctacteItem;
  int registro;

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

                //!-- ADD 2.6
                Visibility(
                  visible: ctacteItem.olId > 0,
                  child: Expanded(
                    flex: ctacteItem.olId > 0 ? 2 : 0,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.rOLGenerica, 
                                      arguments: OLGenericaDetalleRequest(
                                          gEconomicoId:    controller.itemResumenCtaCte.gEconomicoId,
                                          empresaId:       controller.itemResumenCtaCte.empresaId,
                                          olId:            ctacteItem.olId,
                                          tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                          showDatosMonetarios: false,
                                          showDatosMonetariosOperario: true,
                                          operarioClienteId: controller.itemResumenCtaCte.clienteId
                                        )),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kTLightPrimaryColor,
                                width: 0.5,
                                style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: kTLightPrimaryColor,
                                    borderRadius:  BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0)),
                                    ),
                                  width: double.infinity,
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text('OL', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0, color: Colors.white)),
                                  )),
                                const SizedBox(height: 3.0),
                                Text('${ctacteItem.olId}',style: const TextStyle(fontSize: 11.0, color: Colors.black54)),
                                const SizedBox(height: 2.0),
                              ],
                          )),
                      ),
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
                          //!-- ADD 2.2
                          Money.fromNumWithCurrency(ctacteItem.importe, controller.enDolares ? Constants.monedaUSD :  Constants.monedaAR).toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: ctacteItem.importe < 0
                                  ? Colors.red
                                  : kTImporteAFavor)),
                    ),
                    Text(
                        //!-- ADD 2.2
                        Money.fromNumWithCurrency(ctacteItem.saldo, controller.enDolares ? Constants.monedaUSD :  Constants.monedaAR).toString(),
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
