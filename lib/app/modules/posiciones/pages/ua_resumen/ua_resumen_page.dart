import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/posiciones/model/ua_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'ua_resumen_controller.dart';


// ignore: must_be_immutable
class UAUsuarioResumenPage extends GetView<UAUsuarioResumenController> {
  
  UAUsuarioResumenPage({Key? key}) : super(key: key);

  UAUsuarioResumenItem? itemResumen;

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
          title: const Text("Mis Posiciones",
              style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
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
                      itemCount: state!.listaUAUsuarioResumenItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        itemResumen = state.listaUAUsuarioResumenItem[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child: ShowUAUsuarioResumenItem(itemResumen: itemResumen!),
                        );
                      }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Buscando información !'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString()),
              ),
          ]
        ));
  }
}


// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowUAUsuarioResumenItem extends StatelessWidget {

  final UAUsuarioResumenItem itemResumen;

  const ShowUAUsuarioResumenItem({
    Key? key,
    required this.itemResumen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.rPOSUsuarioDetalle, arguments: itemResumen),
        child: Card(
          color: kTBackgroundBtnHome,
          elevation: 15,
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
                        const Text('UNIDAD DE ALMACENAMIENTO', style: TextStyle(fontSize: 12.0, color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold)),
                        Text(itemResumen.empresa, style: const TextStyle(fontSize: 12.0, color: kTClientesLabelsColor)),
                        const SizedBox(height: 8.0),
                        Text(itemResumen.ua.toUpperCase(), style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2.0),
                        Text("${itemResumen.cantArticulos.toString()} artículos", style: const TextStyle(fontSize: 13.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4.0),
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
