
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_resumen_saldo.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'remitos_sin_factura_clientes_controller.dart';


class RemitosSinFacturaFiltroClientesPage extends GetView<RemitosSinFacturaFiltroClientesController> {

  RemitosSinFacturaFiltroClientesPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey();
  CtaCteResumenDeSaldosItem? ctaCteResumenDeSaldosItem;

  @override
  Widget build(BuildContext context) {

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
            title: const Column(
              children: [
                Text("Seleccione una Cuenta", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
                Text("Remitos Pendientes de Facturar", style: TextStyle(fontSize: 13.0, color: kTAllLabelsColor)),
              ],
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              kTBackgroundContainer,
              controller.obx(
                (state)=> Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state!.listaDeSaldosDeCtasCtes.length,
                      itemBuilder: (BuildContext context, int index) {
                        ctaCteResumenDeSaldosItem = state.listaDeSaldosDeCtasCtes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                          child: ShowCtaCteResumenItem(itemResumenCtaCte: ctaCteResumenDeSaldosItem!),
                        );
                      }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Aguarde un momento ...'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString()),
              ),
          ]
        )));
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
      onTap: () => Get.toNamed(AppRoutes.rRemitosSinFacturaListaPage, arguments: { "itemResumenCtaCte": itemResumenCtaCte }),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white24, width: 0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        color: kTBackgroundBtnHome.withOpacity(0.9),
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_forward_ios, color: kTAllLabelsColor),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}