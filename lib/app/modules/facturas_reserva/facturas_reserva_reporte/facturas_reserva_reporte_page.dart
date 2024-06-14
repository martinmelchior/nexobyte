import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import '../model/factura_reserva_model.dart';
import 'facturas_reserva_reporte_controller.dart';

// ignore: must_be_immutable
class FacturasReservaReportePage extends GetView<FacturasReservaReporteController> {
  
  FacturasReservaReportePage({Key? key}) : super(key: key);

  ArticuloPendienteItem? articuloPendienteItem;

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
              "Artículos Pendientes\n${controller.itemResumenCtaCte.cliente}",
              style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        floatingActionButton: Obx(() => 
          controller.showButton.value 
            ? FloatingActionButton(
                elevation: 10,
                child: Image.asset(Constants.kImgPDF, width: 35, height: 35),
                //backgroundColor: kTBackgroundColorBtnIngresarLogin,
                foregroundColor: Colors.white,
                onPressed: () async {
                  await Get.toNamed(AppRoutes.rFacturaReservaDownload, arguments: {
                    "itemResumenCtaCte": controller.itemResumenCtaCte,
                    "mostrarColDolares": false,
                  });
                },
              )
            : const Text('')
        ),
        body: Stack(children: [
          kTBackgroundContainer,
          controller.obx(
            (state) => Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Lista de artículos facturados Pendientes de Remitar', style: TextStyle(color: kTAllLabelsColor)),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state!.listaDeArticulos.length,
                      itemBuilder: (BuildContext context, int index) {
                        articuloPendienteItem = state.listaDeArticulos[index];
                        return Column(
                          children: [
                            ShowArticuloPendienteItem(articuloPendienteItem: articuloPendienteItem!),
                          ],
                        );
                      }),
                ),
              ],
            ),
            onLoading: const MyProgressIndicactor(
                mensaje: 'Aguarde un momento ...'),
            onEmpty: const MyDataNotFoundMessage(mensaje: 'Parece que no tienes Artículos pendientes de Remitar !'),
            onError: (error) => MyCustomErrorMessage(error: error.toString()),
          ),
        ]));
  }
}

// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowArticuloPendienteItem extends StatelessWidget {
  
  final ArticuloPendienteItem articuloPendienteItem;

  const ShowArticuloPendienteItem({
    Key? key,
    required this.articuloPendienteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white60),
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
                  articuloPendienteItem.descripcion.trim().toUpperCase(),
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: Text('Cantidad Pendiente', style: TextStyle(fontSize: 13.0, color: kTAllLabelsColor))),
                  Expanded(child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,    
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Text(articuloPendienteItem.cantidad.toString(), textAlign: TextAlign.right, style: const TextStyle(fontSize: 18.0, color: kTBackgroundColorBtnIngresarLogin))),
                        const SizedBox(width: 10.0),
                        Text(articuloPendienteItem.um, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12.0, color: kTBackgroundColorBtnIngresarLogin)),
                      ],
                    )),                                    
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
