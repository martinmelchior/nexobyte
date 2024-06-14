import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/utils/utils.dart';
import "package:intl/intl.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'detalle_entregas_leche_controller.dart';

final numberFormat = NumberFormat("#,##0.00", "es_AR");
final litrosFormat = NumberFormat("#,###", "es_AR");

class DetalleEntregasLechePage extends GetView<DetalleEntregasLecheController> {
  DetalleEntregasLechePage({Key? key}) : super(key: key);

  EntregaLecheItem? entregaLeche;
  var registro = 0;

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
              child: Tambos.showHeaderTamboDetail(controller.itemCtaCteLecheResumenDeLitrosMesItem),
              height: 195.0),
          preferredSize: const Size.fromHeight(195.0),
        ),
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: const Text("Detalle de Entregas", style: TextStyle(fontSize: 18, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => ListView.builder(
            shrinkWrap: true,
            itemCount: state!.listaEntregasLeche.length,
            itemBuilder: (BuildContext context, int index) {
              entregaLeche = state.listaEntregasLeche[index];
              registro++;
              return ShowEntregaLecheItem(
                  entregaLecheItem: entregaLeche!, registro: registro);
            }),
        onLoading:
            const MyProgressIndicactor(mensaje: 'Buscando entregas de leche !'),
        onEmpty: const MyDataNotFoundMessage(),
        onError: (error) => MyCustomErrorMessage(error: error.toString()),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowEntregaLecheItem extends StatelessWidget {
  EntregaLecheItem entregaLecheItem;
  int registro;

  ShowEntregaLecheItem({
    Key? key,
    required this.entregaLecheItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : Colors.grey.withAlpha(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          DateFormat("dd-MM-yyyy")
                              .format(entregaLecheItem.fecha),
                          style: const TextStyle(
                              fontSize: 12.0, color: kTAllLabelsColor)),
                      const Expanded(child: SizedBox(height: 1.0)),
                      Text(
                          "${litrosFormat.format(entregaLecheItem.totalLeche)}  lts",
                          style: const TextStyle(
                              fontSize: 13.0, color: kTAllLabelsColor)),
                      const Expanded(child: SizedBox(height: 1.0)),
                      Text(
                          "${litrosFormat.format(entregaLecheItem.saldo)}  lts",
                          style: const TextStyle(
                              fontSize: 13.0, color: kTAllLabelsColor)),
                      const Expanded(child: SizedBox(height: 1.0)),
                      !entregaLecheItem.esOficial
                          ? Column(children: [
                              const Text('Tem',
                                  style: TextStyle(
                                      fontSize: 11, color: kTAllLabelsColor)),
                              Tambos.crearAlertaSemaforo(
                                  entregaLecheItem.temperaturaAlerta),
                              Text(
                                  "${entregaLecheItem.temperatura.toInt().toString()} °",
                                  style: const TextStyle(
                                      fontSize: 11, color: kTAllLabelsColor)),
                            ])
                          : const SizedBox(width: 30),
                    ],
                  ),
                  entregaLecheItem.esOficial
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Tambos.crearTablaDeAlertaEsMuestraOficial(entregaLecheItem, kTAllLabelsColor),
                              const SizedBox(height: 10),
                              ActionChip(
                                label: const Text('Ver valores de muestra'),
                                labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                                onPressed: () => _showValoresMuestraOficial(context),
                                backgroundColor: Colors.white70,
                                shape: const StadiumBorder(
                                  side: BorderSide(width: 1, color: Colors.grey),
                                ),
                              ),
                            ],
                          ))
                      : const SizedBox(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showValoresMuestraOficial(BuildContext context) {
    return showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.50,
                //padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.white38,
                      width: 2.0
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Tambos.crearMuestraOficialConValores(entregaLecheItem, kTImporteAFavor),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(
                                    kTRedColor)),
                        child: const Text('Cerrar'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                )));
  }
}
