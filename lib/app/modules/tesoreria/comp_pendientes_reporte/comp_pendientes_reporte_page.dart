import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money2/money2.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:nexobyte/app/utils/utils.dart';

import '../model/tesoreria_model.dart';
import 'comp_pendientes_reporte_controller.dart';

// ignore: must_be_immutable
class CompPendientesReportePage extends GetView<CompPendientesReporteController> {
  CompPendientesReportePage({Key? key}) : super(key: key);

  ComprobantePendienteItem? comprobantePendienteItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: Text(
              "Comprobantes Pendientes\n${controller.itemResumenCtaCte.cliente}",
              style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        floatingActionButton: Obx(() => 
          controller.showButton.value 
            ? FloatingActionButton(
                elevation: 10,
                child: Image.asset(Constants.kImgPDF, width: 35, height: 35),
                onPressed: () async {
                  await Get.toNamed(AppRoutes.rCompPendDownload, arguments: {
                    "itemResumenCtaCte": controller.itemResumenCtaCte,
                    "mostrarColDolares": PreferenciasDeUsuarioStorage
                        .showColDolaresEnRepCompPendientes,
                  });
                },
              )
            : const Text('')
        ),
        body: Stack(children: [
          kTBackgroundContainer,
          controller.obx(
            (state) => ListView.builder(
                shrinkWrap: true,
                itemCount: state!.listaDeComprobantesPendientes.length,
                itemBuilder: (BuildContext context, int index) {
                  comprobantePendienteItem =
                      state.listaDeComprobantesPendientes[index];
                  return ShowComprobantePendienteItem(
                      comprobantePendienteItem: comprobantePendienteItem!);
                }),
            onLoading: const MyProgressIndicactor(
                mensaje: 'Buscando comprobantes pendientes !'),
            onEmpty: const MyDataNotFoundMessage(),
            onError: (error) => MyCustomErrorMessage(error: error.toString()),
          ),
        ]));
  }
}

// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowComprobantePendienteItem extends StatelessWidget {
  final ComprobantePendienteItem comprobantePendienteItem;

  const ShowComprobantePendienteItem({
    Key? key,
    required this.comprobantePendienteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white54),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${comprobantePendienteItem.tipoComprobante.trim().toUpperCase()}  - Nro ( ${comprobantePendienteItem.nroComprobante.trim().toUpperCase()} )',
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Fecha',
                              style: TextStyle(
                                  fontSize: 13.0, color: kTAllLabelsColor)),
                          Text(
                              dateFormatDMY
                                  .format(comprobantePendienteItem.fecha)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: kTClientesLabelsColor)),
                        ],
                      )),
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Fecha Vto',
                              style: TextStyle(
                                  fontSize: 13.0, color: kTAllLabelsColor)),
                          Text(
                              dateFormatDMY
                                  .format(comprobantePendienteItem.fVto)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: comprobantePendienteItem.vencido
                                      ? kTRedColor
                                      : kTBackgroundColorBtnIngresarLogin)),
                        ],
                      )),
                ],
              ),
              //*------------------------------------------- importe y saldo
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Importe',
                              style: TextStyle(
                                  fontSize: 13.0, color: kTAllLabelsColor)),
                          Text(
                              Money.fromNumWithCurrency(
                                      comprobantePendienteItem.importe,
                                      Constants.monedaAR)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: kTBackgroundColorBtnIngresarLogin)),
                        ],
                      )),
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Saldo',
                              style: TextStyle(
                                  fontSize: 13.0, color: kTAllLabelsColor)),
                          Text(
                              Money.fromNumWithCurrency(
                                      comprobantePendienteItem.saldo,
                                      Constants.monedaAR)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: kTBackgroundColorBtnIngresarLogin)),
                        ],
                      )),
                ],
              ),
              //*------------------------------------------- dolar
              Visibility(
                visible: PreferenciasDeUsuarioStorage
                    .showColDolaresEnRepCompPendientes,
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Importe',
                                    style: TextStyle(
                                        fontSize: 13.0, color: kTAllLabelsColor)),
                                Text(
                                    Money.fromNumWithCurrency(
                                            comprobantePendienteItem
                                                .importeDolar,
                                            Constants.monedaUSD)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: kTBackgroundColorBtnIngresarLogin)),
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Saldo',
                                    style: TextStyle(
                                        fontSize: 13.0, color: kTAllLabelsColor)),
                                Text(
                                    Money.fromNumWithCurrency(
                                            comprobantePendienteItem.saldoDolar,
                                            Constants.monedaUSD)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: kTBackgroundColorBtnIngresarLogin)),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
