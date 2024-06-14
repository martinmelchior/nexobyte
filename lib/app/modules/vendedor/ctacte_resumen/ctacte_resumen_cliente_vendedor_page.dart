import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:money2/money2.dart';
import 'ctacte_resumen_cliente_vendedor_controller.dart';

// ignore: must_be_immutable
class CtaCteResumenDeSaldosClientesVendedorPage
    extends GetView<CtaCteResumenDeSaldosClientesVendedorController> {
  CtaCteResumenDeSaldosClientesVendedorPage({Key? key}) : super(key: key);

  CtaCteResumenDeSaldosItem? ctaCteResumenDeSaldosItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: const Text("Ctas  Ctes  Clientes", style: TextStyle(fontSize: 16.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(children: [
          kTBackgroundContainer,
          controller.obx(
            (state) => Column(children: [
              //*------------------------------------------------------------ PILLS
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: controller.kListaAbecedario
                            .map((l) => Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: FilterChip(
                                      elevation: 5,
                                      backgroundColor: kTPillsBackColor,
                                      selectedColor: kTPillsSelectedColor,
                                      label: Text('  $l  ',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      onSelected: (b) {
                                        controller.filtrarClientes(b, l);
                                      }),
                                ))
                            .toList())),
              ),

              //*------------------------------------------------------------ Boton para limpiar el filtro
              Visibility(
                visible: controller.filtrando.value &&
                    controller.response.listaDeSaldosDeCtasCtes.isEmpty,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      "No existen Clientes con el filtro seleccionado !",
                      style: TextStyle(color: kTAllLabelsColor)),
                ),
              ),

              //*------------------------------------------------------------ LISTVIEW de cuentas corrientes
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state!.listaDeSaldosDeCtasCtes.length,
                    itemBuilder: (BuildContext context, int index) {
                      ctaCteResumenDeSaldosItem =
                          state.listaDeSaldosDeCtasCtes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        child: ShowCtaCteResumenItem(
                            itemResumenCtaCte: ctaCteResumenDeSaldosItem!),
                      );
                    }),
              ),

              //*------------------------------------------------------------ Boton para limpiar el filtro
              Visibility(
                visible: controller.filtrando.value,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FilterChip(
                      elevation: 5,
                      backgroundColor: kTPillsBackColor,
                      selectedColor: kTPillsSelectedColor,
                      label: const Text("    Ver todos    ",
                          style: TextStyle(color: Colors.white)),
                      onSelected: (b) {
                        controller.filtrarClientes(false, '');
                      }),
                ),
              ),
            ]),
            onLoading: const Center(
                child: MyProgressIndicactor(
                    mensaje:
                        'Buscando cuentas corrientes de tus clientes asignados !')),
            onEmpty: const MyDataNotFoundMessage(),
            onError: (error) => MyCustomErrorMessage(error: error.toString()),
          )
        ]));
  }
}

// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowCtaCteResumenItem extends StatelessWidget {
  final CtaCteResumenDeSaldosItem itemResumenCtaCte;

  const ShowCtaCteResumenItem({
    Key? key,
    required this.itemResumenCtaCte,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.rCtacteDetalleClienteVEN,
          arguments: itemResumenCtaCte),
      child: Card(
        color: kTBackgroundBtnHome.withOpacity(0.9),
        // elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(itemResumenCtaCte.cliente,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: kTClientesLabelsColor,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2.0),
                      Text(itemResumenCtaCte.empresa,
                          style: const TextStyle(
                              fontSize: 12.0, color: kTClientesLabelsColor)),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Text('Saldo   ',
                              style: TextStyle(
                                  fontSize: 10, color: kTClientesLabelsColor)),
                          //-- ADD 2.2
                            Text(Money.fromNumWithCurrency(itemResumenCtaCte.saldo, itemResumenCtaCte.usaCtaCteDolares 
                                                                                      ? Constants.monedaUSD 
                                                                                      : Constants.monedaAR).toString(), 
                                  style: TextStyle(
                                    // shadows: 
                                    //   (double.parse(itemResumenCtaCte.saldo.toStringAsFixed(2)) > 0.0)
                                    //     ? const [ kTShadowImporteAFavor ]
                                    //     : (double.parse(itemResumenCtaCte.saldo.toStringAsFixed(2)) <= 0.0) 
                                    //       ? const [ kTShadowImporteEnContra ]
                                    //       : const [ kTShadowImporteEnContra ],
                                    fontSize: 18.0, 
                                    fontWeight: FontWeight.bold, 
                                    color: (double.parse(itemResumenCtaCte.saldo.toStringAsFixed(2)) < 0.0) 
                                            ? kTImporteEnContra
                                            : (double.parse(itemResumenCtaCte.saldo.toStringAsFixed(2)) > 0.0) 
                                              ? kTImporteAFavor
                                              : kTClientesLabelsColor)),
                            const SizedBox(width: 10.0),
                            (double.parse(itemResumenCtaCte.saldo.toStringAsFixed(2)) < 0.0) 
                              ? const Icon(Icons.arrow_downward, color: kTImporteEnContra, size: 28) 
                              : (double.parse(itemResumenCtaCte.saldo.toStringAsFixed(2)) > 0.0) 
                                ? const Icon(Icons.arrow_upward, color: kTImporteAFavor, size: 28)
                                : Container(),
                        ],
                      ),

                      // * --------------------------------------------------------------------------------------- Saldo VENCIDO
                      Visibility(
                        visible: itemResumenCtaCte.saldoAVencer != 0,
                        child: Row(
                          children: [
                            const Text('A Vencer   ',
                                style: TextStyle(
                                    fontSize: 10, color: kTClientesLabelsColor)),
                            Text(
                                Money.fromNumWithCurrency(
                                        itemResumenCtaCte.saldoAVencer,
                                        Constants.monedaAR)
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: itemResumenCtaCte.saldo < 0
                                        ? kTImporteEnContra
                                        : kTImporteAFavor)),
                            const SizedBox(width: 10.0),
                            (double.parse(itemResumenCtaCte.saldo
                                        .toStringAsFixed(2)) <
                                    0)
                                ? const Icon(Icons.arrow_downward,
                                    color: kTImporteEnContra, size: 15)
                                : const Icon(Icons.arrow_upward,
                                    color: kTImporteAFavor, size: 15),
                          ],
                        ),
                      ),

                      //*------------------------------------------------------ Compartir Resumen de Cta Cte
                        //!-- ADD 3.0
                         Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: InkWell(
                              focusColor: Colors.white,
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.share, color: kTLabelTextBoxLogin),
                                    SizedBox(width: 10.0),
                                    Text('Compartir', style: TextStyle(fontSize: 14.0, color: kTClientesLabelsColor)),
                                  ],
                              ),
                              onTap: () => Get.toNamed(AppRoutes.rCtaCteResumenXls, arguments: { "itemResumenCtaCte": itemResumenCtaCte, "enDolares": false }),
                            ),
                          ),

                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_forward_ios,
                            color: kTLightPrimaryColor),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
