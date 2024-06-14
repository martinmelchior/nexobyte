import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:money2/money2.dart';
import '../../../data/models/preferencias_de_usuario_model.dart';
import '../../adelantos/utils/adelanto_constants.dart';
import 'ctacte_resumen_controller.dart';


// ignore: must_be_immutable
class CtaCteResumenDeSaldosPage extends GetView<CtaCteResumenDeSaldosController> {
  
  CtaCteResumenDeSaldosPage({Key? key}) : super(key: key);

  CtaCteResumenDeSaldosItem? ctaCteResumenDeSaldosItem;

  @override
  Widget build(BuildContext context) {

    //-- ADD 2.2
    String _titulo = "Resumen de Ctas Ctes";
    if (controller.enDolares) _titulo += "\nen dolares";

    return Scaffold(
        //backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: Text(_titulo, style: const TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              kTBackgroundContainer,
              controller.obx(
                (state)=> Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state!.listaDeSaldosDeCtasCtes.length,
                      itemBuilder: (BuildContext context, int index) {
                        ctaCteResumenDeSaldosItem = state.listaDeSaldosDeCtasCtes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child: ShowCtaCteResumenItem(itemResumenCtaCte: ctaCteResumenDeSaldosItem!),
                        );
                      }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Buscando tus cuentas corrientes !'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString()),
              ),
          ]
        ));
  }
}


// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowCtaCteResumenItem extends StatelessWidget {

  //-- ADD 2.2
  final CtaCteResumenDeSaldosController controller = Get.find<CtaCteResumenDeSaldosController>();

  final CtaCteResumenDeSaldosItem itemResumenCtaCte;

  ShowCtaCteResumenItem({
    Key? key,
    required this.itemResumenCtaCte,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
        //-- ADD 2.2
        onTap: () => Get.toNamed(AppRoutes.rCtacteClienteDetalle, arguments: { "itemResumenCtaCte": itemResumenCtaCte, "enDolares": controller.enDolares }),
        child: Card(
          color: kTBackgroundBtnHome.withOpacity(0.9),
          //elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemResumenCtaCte.cliente, style: const TextStyle(fontSize: 16.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold)),
                        //Text("HOMERO MALCONE (cta " + itemResumenCtaCte.clienteId.toString() + ")", style: const TextStyle(fontSize: 16.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2.0),
                        Text(itemResumenCtaCte.empresa, style: const TextStyle(fontSize: 12.0, color: kTClientesLabelsColor)),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Text('Saldo   ', style: TextStyle(fontSize: 10, color: kTClientesLabelsColor)),
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

                        // * --------------------------------------------------------------------------------------- Saldo A VENCER
                        Visibility(
                          visible: itemResumenCtaCte.saldoAVencer != 0,
                          child: Row(
                            children: [
                              //-- ADD 2.2 - se modifico saldo por saldoAVencer
                              const Text('A Vencer   ', style: TextStyle(fontSize: 10, color: kTClientesLabelsColor)),
                              Text(Money.fromNumWithCurrency(itemResumenCtaCte.saldoAVencer, itemResumenCtaCte.usaCtaCteDolares 
                                                                                              ? Constants.monedaUSD
                                                                                              : Constants.monedaAR).toString(), 
                                    style: TextStyle(
                                      fontSize: 14.0, 
                                      fontWeight: FontWeight.bold, 
                                      color: itemResumenCtaCte.saldoAVencer < 0 ? kTImporteEnContra : kTImporteAFavor)),
                              const SizedBox(width: 10.0),
                              (double.parse(itemResumenCtaCte.saldoAVencer.toStringAsFixed(2)) < 0) 
                                ? const Icon(Icons.arrow_downward, color: kTImporteEnContra, size: 15) 
                                : const Icon(Icons.arrow_upward, color: kTImporteAFavor, size: 15),
                            ],
                          ),
                        ),
                        
                        //*------------------------------------------------------ Compartir Resumen de Cta Cte
                        //!-- ADD 3.0
                        Visibility(
                          visible: !controller.enDolares,
                          child: Padding(
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
                              onTap: () => Get.toNamed(AppRoutes.rCtaCteResumenXls, arguments: { "itemResumenCtaCte": itemResumenCtaCte, "enDolares": controller.enDolares }),
                            ),
                          ),
                        ),
                        

                        //*------------------------------------------------------ Solicitud de Adelantos
                        //!-- ADD 3.2
                        Visibility(
                          visible: !controller.enDolares && PreferenciasDeUsuarioStorage.showSolicitudDeAdelantos,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: InkWell(
                              child: Column(
                                children: [
                                  const SizedBox(height: 5.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(AdelantoConstants.kImgAdelantos, width: 30, height: 30),
                                      const SizedBox(width: 10.0),
                                      const Expanded(child: Text('Solicita Efectivo, Cheques o Transferencias a cuentas propias u otras cuentas.', style: TextStyle(fontSize: 13.0, color: kTClientesLabelsColor))),
                                    ],
                                ),
                                ],
                              ),
                              onTap: () => Get.toNamed(AppRoutes.rSolicitudAdelantoLista, arguments: { "itemResumenCtaCte": itemResumenCtaCte, "enDolares": controller.enDolares }),
                            ),
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
