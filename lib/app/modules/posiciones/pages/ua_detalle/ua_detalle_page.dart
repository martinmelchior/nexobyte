import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_detalle/ua_detalle_controller.dart';
import 'package:nexobyte/app/routes/routes_app.dart';

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

class UAUsuarioDetalleListaPage extends GetView<UAUsuarioDetalleController> {
  
  int registro = 0;
  String letra = '--';
  bool showLetra = true;

  UAUsuarioDetalleItem? dataItem;

  UAUsuarioDetalleListaPage({Key? key}) : super(key: key);

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
            Text("${controller.uaResumenItem.cantArticulos.toString()} artículos en", style: const TextStyle(fontSize: 13.0, fontFamily: 'Sora', color: kTIconColor)),
            const SizedBox(height: 5),
            Text(controller.uaResumenItem.ua, style: const TextStyle(fontSize: 13.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
          ],
        ),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Stack(
          children: [
            ListView.separated(
              controller: controller.scrollController,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => Container(),
              itemCount: state!.listaUAUsuarioDetalleItem.length,
              itemBuilder: (BuildContext context, int index) {
                dataItem = state.listaUAUsuarioDetalleItem[index];
                registro++;
                return ShowItem(item: dataItem!, registro: registro);
              }),
            Obx(() => Visibility(
              visible: controller.loading.value && controller.request.pageNro > 1,
              child: const Column(
                children: [
                  Expanded(child: SizedBox()),
                  SizedBox(width: double.infinity, child: Center(child: kTLpi)),
                ],
              ))),
        ]),
        onLoading: const MyProgressIndicactor(mensaje: 'Buscando artículos !'),
        onEmpty: const MyDataNotFoundMessage(),
        onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ARTICULOS
// ignore: must_be_immutable
class ShowItem extends StatelessWidget {
  UAUsuarioDetalleItem item;
  int registro;

  ShowItem({
    Key? key,
    required this.item,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UAUsuarioDetalleController c = Get.find<UAUsuarioDetalleController>();

    
    if (c.letra.value != item.articulo[0])
    {
      c.letra.value = item.articulo[0];
      c.showLetra.value = true;
    }
    else
    {
      c.showLetra.value = false;
    }

    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Get.toNamed(AppRoutes.rPOSMovStock, arguments: item),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Visibility(
                      visible: c.showLetra.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kTLightPrimaryColor2,
                          border: Border.all(color: kTLightPrimaryColor2),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: Center(child: Text(c.letra.value, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))))),
                  ),
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.articulo),
                          const SizedBox(height: 5.0),
                          Text(item.rubro, style: const TextStyle(fontSize: 11.0)),
                          const SizedBox(height: 5.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("${item.stock} ${item.unidad.toLowerCase()}",
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: kTImporteAFavor,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 5.0),
                              const Text("en stock",
                                  style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: item.existeMov,
                    child: const Expanded(
                      flex: 2,
                      child: Icon(Icons.menu_rounded, size: 22.0, color: Colors.black38),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
