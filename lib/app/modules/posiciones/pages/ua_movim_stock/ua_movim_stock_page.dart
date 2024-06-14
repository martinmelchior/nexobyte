import 'package:intl/intl.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'ua_movim_stock_controller.dart';

class UAMovimientoStockListaPage extends GetView<UAMovimientoStockController> {
  
  int registro = 0;

  UAMovimientoStockItem? dataItem;

  UAMovimientoStockListaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: Column(
          children: [
            Text(controller.uaUsuarioResumenItemMovStockItem.articulo, style: const TextStyle(fontSize: 13.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${controller.uaUsuarioResumenItemMovStockItem.stock} ${controller.uaUsuarioResumenItemMovStockItem.unidad.toLowerCase()}", style: const TextStyle(fontSize: 15.0, color: kTImporteAFavor, fontWeight: FontWeight.bold)),
                const SizedBox(width: 5.0),
                const Text("en stock", style: TextStyle(fontSize: 12.0)),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Stack(children: [
          ListView.separated(
            controller: controller.scrollController,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Container(),
            itemCount: state!.listaUAMovimientosDeStock.length,
            itemBuilder: (BuildContext context, int index) {
              dataItem = state.listaUAMovimientosDeStock[index];
              registro++;
              return ShowItem(item: dataItem!, registro: registro, unidad: controller.uaUsuarioResumenItemMovStockItem.unidad.toLowerCase());
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
                ))),
            ]),
        onLoading: const MyProgressIndicactor(mensaje: 'Buscando movimientos !'),
        onEmpty: const MyDataNotFoundMessage(),
        onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ARTICULOS 
// ignore: must_be_immutable
class ShowItem extends StatelessWidget {
  
  UAMovimientoStockItem item;
  int registro;
  String unidad;

  ShowItem({
    Key? key,
    required this.item,
    required this.registro,
    required this.unidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat("dd-MM-yyyy").format(item.fecha), style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                          const SizedBox(height: 5.0),
                          Text(item.comprobante, style: const TextStyle(fontSize: 13.0)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          item.entrada > item.salida 
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.play_arrow, color: kTImporteAFavor),
                                const SizedBox(width: 5.0),
                                Text("${item.entrada} $unidad", style: const TextStyle(fontSize: 15.0, color: kTImporteAFavor)),
                              ],
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${item.salida} $unidad", style: const TextStyle(fontSize: 15.0, color: kTImporteEnContra)),
                                const SizedBox(width: 5.0),
                                const Icon(Icons.play_arrow, color: kTImporteEnContra),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
              ),
    );
  }
}
