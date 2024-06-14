import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'ordenes_laboreo_ingeniero_resumen_controller.dart';



// ignore: must_be_immutable
class OrdenesLaboreosResumenDeIngenieroPage extends GetView<OrdenesLaboreosResumenDeIngenieroController> {
  
  OrdenesLaboreosResumenDeIngenieroPage({Key? key}) : super(key: key);

  OrdenesLaboreosResumenDeIngenieroItem? ordenesLaboreosResumenDeContratistasItem;

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
          title: const Text("Resumen Ingeniero",
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
                      itemCount: state!.listaResumenDeIngenierosItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        ordenesLaboreosResumenDeContratistasItem = state.listaResumenDeIngenierosItem[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child: ShowContratistaResumenItem(itemResumen: ordenesLaboreosResumenDeContratistasItem!),
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
class ShowContratistaResumenItem extends StatelessWidget {

  final OrdenesLaboreosResumenDeIngenieroItem itemResumen;

  const ShowContratistaResumenItem({
    Key? key,
    required this.itemResumen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    List<Widget> listaWidgetEstados = itemResumen.listaDeEstados.map((element) 
    { 
        String _cant = element.cantidad.toString();
        String _estado = element.estado.toString();

        return RichText(
                text: TextSpan( 
                  style: const TextStyle(fontSize: 16.0),
                  children: <TextSpan>[
                    const TextSpan(text: 'Tienes ', style: TextStyle(color: kTClientesLabelsColor)),
                    TextSpan(text: _cant, style: const TextStyle(color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold, fontSize: 19.0)),
                    const TextSpan(text: '  OLs  ', style: TextStyle(color: kTClientesLabelsColor)),
                    TextSpan(text: _estado.toUpperCase(), style: const TextStyle(color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' !', style: TextStyle(color: kTClientesLabelsColor)),
                  ],
                ),
              );
    }).toList();
    

    return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.rMenuIngenieros, arguments: itemResumen),
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
                        const Text('Resumen de gestión de Explotaciones Agropecuarias', style: TextStyle(fontSize: 14.0, color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4.0),
                        Text(itemResumen.empresa, style: const TextStyle(fontSize: 13.0, color: kTClientesLabelsColor)),
                        const Divider(color: Colors.white30, height: 30.0),
                        ...listaWidgetEstados
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
