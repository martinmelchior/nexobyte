import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/utils.dart';
import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'mov_interno_list_controller.dart';



// ignore: must_be_immutable
class MovInternoListPage extends GetView<MovInternoListController> {
  
  MovInternoListPage({Key? key}) : super(key: key);

  MovimientoInterno movInternoItem = MovimientoInterno();
  var registro = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(Icons.add),
          backgroundColor: kTBackgroundColorBtnIngresarLogin,
          foregroundColor: Colors.white,
          onPressed: () async {
            try {
              bool reloadList = await Get.toNamed(AppRoutes.rMovInternoItem, 
                                                  arguments: { 
                                                    "requestEARerources": controller.paramReqEAResources, 
                                                    "eaResources": controller.eaResources,
                                                    "movId": -1 });
              if (reloadList)
              {
                await controller.obtenerMovimientosInternos();
              }
            }
            catch (e) {
              Get.back();
            } 
          },
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: const Text("Movimientos Internos",
              style: TextStyle(fontSize: 16.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              controller.obx(
                (state) =>  RefreshIndicator(
                  color: kTLabelEspecieResumenHome,
                  backgroundColor: kTLightPrimaryColor3,
                  onRefresh: () async => await controller.obtenerMovimientosInternos(),
                  child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state!.movimientos.length,
                        itemBuilder: (BuildContext context, int index) {
                          movInternoItem = state.movimientos[index];
                          registro++;
                          return ShowMovInternoItem(movInterno: movInternoItem, registro: registro);
                        }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Espere un momento !'),
                onEmpty: const MyDataNotFoundMessage(colorText: kTLightPrimaryColor),
                onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTLightPrimaryColor1),
              ),
          ]
        ));
  }
}


// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowMovInternoItem extends StatelessWidget {

  final MovInternoListController _controller = Get.find<MovInternoListController>();

  final MovimientoInterno movInterno;
  final int registro;

  ShowMovInternoItem({
    Key? key,
    required this.movInterno,
    required this.registro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 3,
                //child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: movInterno.estado == 'ANULADO' ? kTImporteEnContra.withOpacity(0.6) : kTImporteAFavor.withOpacity(0.6)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
                      child: Text(movInterno.estado!, textAlign: TextAlign.center, 
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                //),//your text
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1,
                            child: Text(movInterno.fechaDescarga == null 
                              ? '' 
                              : DateFormat("dd-MM-yyyy  ( HH:mm )").format(movInterno.fechaDescarga!), style: const TextStyle(fontSize: 13, color: Colors.black54)),
                          ),
                          Expanded(flex: 1, child: Text("${numberFormat.format(movInterno.cantidad)} Kgs", textAlign: TextAlign.end, style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${movInterno.lote!.loteNombre} - ${movInterno.ea!.clienteNombre}", style: const TextStyle(fontSize: 13, color: Colors.black87)),
                            const SizedBox(height: 3.0),
                            Text("${movInterno.especie!.nombre} - ${movInterno.campania!.descripcion}", style: const TextStyle(fontSize: 13, color: Colors.black87)),
                            const SizedBox(height: 3.0),
                            Text(movInterno.usuarioCreacion!, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               )
              ],
            ),
        ],
      )
     
    );
  }
}
