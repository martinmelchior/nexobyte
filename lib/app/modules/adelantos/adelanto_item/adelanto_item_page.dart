import "package:intl/intl.dart";
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/adelantos/utils/adelanto_constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money2/money2.dart';

import '../adelanto_lista/adelanto_lista_page.dart';
import '../model/adelantos_model.dart';
import 'adelanto_item_controller.dart';

class AdelantoItemPage extends GetView<AdelantoItemController> {
  final GlobalKey<FormState> _key = GlobalKey();

  AdelantoItemPage({Key? key}) : super(key: key);

  final TextStyle _labelStyle =
      const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  List<Bubble> listaBubleFull = [];
  List<Bubble> listaBubleShort = [];

  final GlobalKey<ExpansionTileCardState> cardEfectivo = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardCheques = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTransferenciasPropias =
      GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtras = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //*----------------------------------------------- Enviar Solicitur
    Bubble bEnviarSolicitud = Bubble(
      title: "Enviar Solicitud",
      iconColor: Colors.white,
      bubbleColor: Colors.orange,
      icon: Icons.add,
      titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
      onPress: () async {
        controller.animationController.reverse();
        if (_key.currentState!.validate()) {
          //-- Este save() es el que pasa los valores de las cajas de texto al controller!
          _key.currentState!.save();
          bool enviar = await controller.showAlertDialog(context);
          if (enviar) {
            bool result = await controller.enviarSolicitud();
            if (result) {
              Get.back(result: true);
            }
          }
        }
      },
    );
    //*----------------------------------------------- Agregar CBU
    Bubble bAgregarCBU = Bubble(
      title: "Ver tu Agenda CBU",
      iconColor: Colors.white,
      bubbleColor: kTLightPrimaryColor,
      icon: Icons.add,
      titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
      onPress: () async {
        controller.animationController.reverse();
        await Get.toNamed(AppRoutes.rAgendaCbuLista,
            arguments: {'tipoDeCuenta': TipoDeCuenta.todas.toValueText});
      },
    );
    //*----------------------------------------------- Efectivo
    Bubble bEfectivo = Bubble(
      title: "Pedir Efectivo",
      iconColor: Colors.white,
      bubbleColor: kTLightPrimaryColor,
      icon: Icons.add,
      titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
      onPress: () async {
        controller.animationController.reverse();
        SOEfectivo efectivo = await Get.toNamed(
            AppRoutes.rSolicitudEfectivoItem,
            arguments: {'efectivoId': -1});
        controller.rxSolicitudItem.value.listaDeEfectivo = [
          ...controller.rxSolicitudItem.value.listaDeEfectivo,
          efectivo
        ];
        controller.refrescarTotalEfectivo();
        controller.rxSolicitudItem.refresh();
        cardEfectivo.currentState?.expand();
      },
    );
    //*----------------------------------------------- Cheques
    Bubble bCheques = Bubble(
      title: "Pedir Cheques",
      iconColor: Colors.white,
      bubbleColor: kTLightPrimaryColor,
      icon: Icons.add,
      titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
      onPress: () async {
        controller.animationController.reverse();
        SOCheque cheque = await Get.toNamed(AppRoutes.rSolicitudChequeItem,
            arguments: {
              'chequeId': -1,
              'itemResumenCtaCte': controller.itemResumenCtaCte
            });
        controller.rxSolicitudItem.value.listaDeCheques = [
          ...controller.rxSolicitudItem.value.listaDeCheques,
          cheque
        ];
        controller.refrescarTotalCheque();
        controller.rxSolicitudItem.refresh();
        cardCheques.currentState?.expand();
      },
    );
    //*----------------------------------------------- Transfer a ctas propias
    Bubble bCtasPropias = Bubble(
      title: "Transferencia  a  Ctas  PROPIAS",
      iconColor: Colors.white,
      bubbleColor: kTLightPrimaryColor,
      icon: Icons.add,
      titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
      onPress: () async {
        controller.animationController.reverse();
        SOTransferencia transferencia = await Get.toNamed(
            AppRoutes.rSolicitudTransferenciaItem,
            arguments: {
              'transferenciaId': -1,
              'itemResumenCtaCte': controller.itemResumenCtaCte,
              'tipoDeCuenta': TipoDeCuenta.cuentaspropias.toValueText
            });
        controller.rxSolicitudItem.value.listaDeTransferenciasPropias = [
          ...controller.rxSolicitudItem.value.listaDeTransferenciasPropias,
          transferencia
        ];
        controller.refrescarTotalTransferenciasPropias();
        controller.rxSolicitudItem.refresh();
        cardTransferenciasPropias.currentState?.expand();
      },
    );
    //*----------------------------------------------- Transfer a otras ctas
    Bubble bOtrasCuentas = Bubble(
      title: "Transferencia  a  OTRAS  CTAS",
      iconColor: Colors.white,
      bubbleColor: kTLightPrimaryColor,
      icon: Icons.add,
      titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
      onPress: () async {
        controller.animationController.reverse();
        SOTransferencia transferencia = await Get.toNamed(
            AppRoutes.rSolicitudTransferenciaItem,
            arguments: {
              'transferenciaId': -1,
              'itemResumenCtaCte': controller.itemResumenCtaCte,
              'tipoDeCuenta': TipoDeCuenta.otrascuentas.toValueText
            });
        controller.rxSolicitudItem.value.listaDeTransferenciasOtras = [
          ...controller.rxSolicitudItem.value.listaDeTransferenciasOtras,
          transferencia
        ];
        controller.refrescarTotalTransferenciasOtrasCuentas();
        controller.rxSolicitudItem.refresh();
        cardOtras.currentState?.expand();
      },
    );

    //*----------------------------------- lista full
    listaBubleFull.add(bEnviarSolicitud);
    listaBubleFull.add(bAgregarCBU);
    listaBubleFull.add(bEfectivo);
    listaBubleFull.add(bCheques);
    listaBubleFull.add(bCtasPropias);
    listaBubleFull.add(bOtrasCuentas);
    //*----------------------------------- lista parcial
    //listaBuble_short.add(bEnviarSolicitud);
    listaBubleShort.add(bAgregarCBU);

    String titulo = controller.mode == FormMode.insert
        ? 'Nueva Solicitud'
        : 'Modificar Solicitud';

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _key,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: Text(titulo,
              style: const TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
          bottom: PreferredSize(
            child: Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CUENTA ORIGEN DE FONDOS',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Sora',
                            color: kTAllLabelsColor)),
                    Text(controller.itemResumenCtaCte.cliente,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Sora',
                            color: kTRedColor)),
                  ],
                ),
                height: 80.0),
            preferredSize: const Size.fromHeight(80.0),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Visibility(
          child: Obx(() => FloatingActionBubble(
                // Menu items
                items: controller.isPendiente.value
                    ? listaBubleFull
                    : listaBubleShort,
                // animation controller
                animation: controller.animation,
                // On pressed change animation state
                onPress: () => controller.animationController.isCompleted
                    ? controller.animationController.reverse()
                    : controller.animationController.forward(),
                // Floating Action button Icon color
                iconColor: Colors.white,
                // Flaoting Action button Icon
                iconData: Icons.menu,
                backGroundColor: kTBackgroundColorBtnIngresarLogin,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              const SizedBox(height: 30.0),
              Obx(
                () =>
                    //?----------------------------------------- EFECTIVO
                    ExpansionTileCard(
                  key: cardEfectivo,
                  baseColor: Colors.white,
                  leading: Image.asset(AdelantoConstants.kImgEfectivo,
                      width: 30, height: 30),
                  title:
                      const Text('Efectivo', style: TextStyle(fontSize: 14.0)),
                  subtitle: Text(
                      Money.fromNumWithCurrency(
                              controller.rxSolicitudItem.value.totalEfectivo ??
                                  0.0,
                              Constants.monedaAR)
                          .toString(),
                      style: const TextStyle(color: Colors.indigo)),
                  elevation: 0.0,
                  expandedTextColor: kTPillsBackColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          showEfectivo(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Obx(
                () =>
                    //?----------------------------------------- CHEQUES
                    ExpansionTileCard(
                  key: cardCheques,
                  baseColor: Colors.white,
                  leading: Image.asset(AdelantoConstants.kImgCheques,width: 30, height: 30),
                  title:
                      const Text('Cheques', style: TextStyle(fontSize: 14.0)),
                  subtitle: Text(
                      Money.fromNumWithCurrency(
                              controller.rxSolicitudItem.value.totalCheques ??
                                  0.0,
                              Constants.monedaAR)
                          .toString(),
                      style: const TextStyle(color: Colors.indigo)),
                  elevation: 0.0,
                  expandedTextColor: kTPillsBackColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          showCheque(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Obx(
                () =>
                    //?----------------------------------------- TRANSFERENCIAS PROPIAS
                    ExpansionTileCard(
                  key: cardTransferenciasPropias,
                  baseColor: Colors.white,
                  leading: Image.asset(AdelantoConstants.kImgTransferencia1,
                      width: 30, height: 30),
                  title: const Text('Tansferencias a Ctas Propias',
                      style: TextStyle(fontSize: 14.0)),
                  subtitle: Text(
                      Money.fromNumWithCurrency(
                              controller.rxSolicitudItem.value
                                      .totalTransferenciasPropias ??
                                  0.0,
                              Constants.monedaAR)
                          .toString(),
                      style: const TextStyle(color: Colors.indigo)),
                  elevation: 0.0,
                  expandedTextColor: kTPillsBackColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          showTransferenciasPropias(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Obx(
                () =>
                    //?----------------------------------------- TRANSFERENCIAS A OTRAS CUENTAS
                    ExpansionTileCard(
                  key: cardOtras,
                  baseColor: Colors.white,
                  leading: Image.asset(AdelantoConstants.kImgTransferencia2,
                      width: 30, height: 30),
                  title: const Text('Tansferencias a Otras Cuentas',
                      style: TextStyle(fontSize: 14.0)),
                  subtitle: Text(
                      Money.fromNumWithCurrency(controller.rxSolicitudItem.value.totalTransferenciasOtras ?? 0.0, Constants.monedaAR).toString(),
                      style: const TextStyle(color: Colors.indigo)),
                  elevation: 0.0,
                  expandedTextColor: kTPillsBackColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          showOtrasCuentas(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              _observacion(),
              const SizedBox(height: 50.0),
            ]),
          ),
        ),
      ),
    );
  }

  //*----------------------------------------------------------------------- Show Efectivo
  Widget showEfectivo() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Container(),
        itemCount: controller.rxSolicitudItem.value.listaDeEfectivo.length,
        itemBuilder: (BuildContext context, int index) {
          SOEfectivo e = controller.rxSolicitudItem.value.listaDeEfectivo[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat("dd-MM-yyyy").format(e.fechaEntrega!),
                          style: e.estado == 'RECHAZADA' ? kTextStyleLblTipos2Rechazado : kTextStyleLblTipos2,
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                Text(
                    Money.fromNumWithCurrency(e.importe!, Constants.monedaAR)
                        .toString(),
                    style: e.estado == 'RECHAZADA' ? kTextStyleImportesEfectivoRechazado : kTextStyleImportesEfectivo),
                const SizedBox(width: 15.0),
                Visibility(
                  visible: controller.isPendiente.value,
                  child: GestureDetector(
                      onTap: () {
                        controller.rxSolicitudItem.value.listaDeEfectivo
                            .removeWhere((ee) => ee.efectivoId == e.efectivoId);
                        controller.refrescarTotalEfectivo();
                        controller.rxSolicitudItem.refresh();
                      },
                      child: Image.asset(AdelantoConstants.kImgTrash,
                          width: 35, height: 35)),
                ),
              ],
            ),
          );
        });
  }

  //*----------------------------------------------------------------------- Show Cheques
  Widget showCheque() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Container(),
        itemCount: controller.rxSolicitudItem.value.listaDeCheques.length,
        itemBuilder: (BuildContext context, int index) {
          SOCheque c = controller.rxSolicitudItem.value.listaDeCheques[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat("dd-MM-yyyy").format(c.fechaVto!),
                              style: c.estado == 'RECHAZADA' ? kTextStyleLblTipos2Rechazado : kTextStyleLblTipos2,
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                        Money.fromNumWithCurrency(
                                c.importe!, Constants.monedaAR)
                            .toString(),
                        style: c.estado == 'RECHAZADA' ?  kTextStyleImportesChequesRechazado : kTextStyleImportesCheques),
                    const SizedBox(width: 15.0),
                    Visibility(
                      visible: controller.isPendiente.value,
                      child: GestureDetector(
                          onTap: () {
                            controller.rxSolicitudItem.value.listaDeCheques
                                .removeWhere((cc) => cc.chequeId == c.chequeId);
                            controller.refrescarTotalCheque();
                            controller.rxSolicitudItem.refresh();
                          },
                          child: Image.asset(AdelantoConstants.kImgTrash,
                              width: 35, height: 35)),
                    ),
                  ],
                ),
                Text(c.banco!,
                    style: c.estado == 'RECHAZADA' ? kTextStyleLblTipos3Rechazado : kTextStyleLblTipos3, textAlign: TextAlign.start),
              ],
            ),
          );
        });
  }

  //*----------------------------------------------------------------------- Show Transferencias Propias
  Widget showTransferenciasPropias() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Container(),
        itemCount: controller
            .rxSolicitudItem.value.listaDeTransferenciasPropias.length,
        itemBuilder: (BuildContext context, int index) {
          SOTransferencia t = controller
              .rxSolicitudItem.value.listaDeTransferenciasPropias[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  DateFormat("dd-MM-yyyy")
                                      .format(t.fechaTransferencia!),
                                  style: t.estado == 'RECHAZADA' ? kTextStyleLblTipos2Rechazado : kTextStyleLblTipos2,
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                            Money.fromNumWithCurrency(
                                    t.importe!, Constants.monedaAR)
                                .toString(),
                            style: t.estado == 'RECHAZADA' ? kTextStyleImportesPropiasRechazado : kTextStyleImportesPropias),
                        const SizedBox(width: 15.0),
                        Visibility(
                          visible: controller.isPendiente.value,
                          child: GestureDetector(
                              onTap: () {
                                controller.rxSolicitudItem.value
                                    .listaDeTransferenciasPropias
                                    .removeWhere((tt) =>
                                        tt.transferenciaId ==
                                        t.transferenciaId);
                                controller
                                    .refrescarTotalTransferenciasPropias();
                                controller.rxSolicitudItem.refresh();
                              },
                              child: Image.asset(AdelantoConstants.kImgTrash,
                                  width: 35, height: 35)),
                        ),
                      ],
                    ),
                    Text(
                        '${t.descripcion!}  |  ${t.cbuAlias!}  |  ${t.banco!}'
                            .toString(),
                        style: t.estado == 'RECHAZADA' ? kTextStyleLblTipos3Rechazado : kTextStyleLblTipos3,
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          );
        });
  }

//*----------------------------------------------------------------------- Show Transferencias Otras Cuentas
  Widget showOtrasCuentas() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Container(),
        itemCount:
            controller.rxSolicitudItem.value.listaDeTransferenciasOtras.length,
        itemBuilder: (BuildContext context, int index) {
          SOTransferencia t = controller
              .rxSolicitudItem.value.listaDeTransferenciasOtras[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  DateFormat("dd-MM-yyyy")
                                      .format(t.fechaTransferencia!),
                                  style: t.estado == 'RECHAZADA' ? kTextStyleLblTipos2Rechazado : kTextStyleLblTipos2,
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                            Money.fromNumWithCurrency(
                                    t.importe!, Constants.monedaAR)
                                .toString(),
                            style: t.estado == 'RECHAZADA' ? kTextStyleImportesOtrasRechazado : kTextStyleImportesOtras),
                        const SizedBox(width: 15.0),
                        Visibility(
                          visible: controller.isPendiente.value,
                          child: GestureDetector(
                              onTap: () {
                                controller.rxSolicitudItem.value
                                    .listaDeTransferenciasOtras
                                    .removeWhere((tt) =>
                                        tt.transferenciaId ==
                                        t.transferenciaId);
                                controller
                                    .refrescarTotalTransferenciasOtrasCuentas();
                                controller.rxSolicitudItem.refresh();
                              },
                              child: Image.asset(AdelantoConstants.kImgTrash,
                                  width: 35, height: 35)),
                        ),
                      ],
                    ),
                    Text(
                        '${t.descripcion!}  |  ${t.cbuAlias!}  |  ${t.banco!}'
                            .toString(),
                        style: t.estado == 'RECHAZADA' ? kTextStyleLblTipos3Rechazado : kTextStyleLblTipos3,
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          );
        });
  }

  //*------------------------------------------------------------------------------------------------------ OBSERVACION
  Widget _observacion() {
    return Obx(() => TextFormField(
          enabled: controller.isPendiente.value,
          minLines: 2,
          maxLines: 5,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            enabledBorder: _enabledBorder,
            focusedBorder: _focusedBorder,
            labelText: 'Comentario',
            labelStyle: _labelStyle,
            disabledBorder: InputBorder.none,
          ),
          keyboardType: TextInputType.multiline,
          controller: controller.txtObservacionController,
          onSaved: (o) {
            controller.rxSolicitudItem.value.observacion = o;
          },
        ));
  }
}
