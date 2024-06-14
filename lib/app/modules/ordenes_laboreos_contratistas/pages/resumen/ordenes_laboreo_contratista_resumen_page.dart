import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'ordenes_laboreo_contratista_resumen_controller.dart';


// ignore: must_be_immutable
class OrdenesLaboreosResumenDeContratistaPage extends GetView<OrdenesLaboreosResumenDeContratistaController> {
  
  OrdenesLaboreosResumenDeContratistaPage({Key? key}) : super(key: key);

  OrdenesLaboreosResumenDeContratistasItem? ordenesLaboreosResumenDeContratistasItem;

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
          title: const Text("Resumen de Contratista",
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
                      itemCount: state!.listaResumenDeContratistasItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        ordenesLaboreosResumenDeContratistasItem = state.listaResumenDeContratistasItem[index];
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

  final OrdenesLaboreosResumenDeContratistasItem itemResumen;

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
                  style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor),
                  children: <TextSpan>[
                    //const TextSpan(text: 'Tienes '),
                    TextSpan(text: _cant, style: const TextStyle(color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold, fontSize: 19.0)),
                    const TextSpan(text: '  OLs  '),
                    TextSpan(text: _estado, style: const TextStyle(color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' !'),
                  ],
                ),
              );
    }).toList();
    

    return GestureDetector(
        //onTap: () => Get.toNamed(AppRoutes.rDetalleOLUsuario, arguments: itemResumen),
        onTap: () => Get.toNamed(AppRoutes.rMenuContratista, arguments: itemResumen),
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
                        const Text('CONTRATISTA', style: TextStyle(fontSize: 11.0, color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold)),
                        Text(itemResumen.contratista, style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4.0),
                        Text(itemResumen.empresa, style: const TextStyle(fontSize: 11.0, color: kTClientesLabelsColor)),
                        const Divider(color: Colors.white30, height: 30.0),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan( 
                            style: const TextStyle(fontSize: 17.0, color: kTAllLabelsColor),
                            children: <TextSpan>[
                              const TextSpan(text: 'Se te han asignado '),
                              TextSpan(text: itemResumen.cantidadTotalOLs.toString(), style: const TextStyle(color: kTLabelEspecieResumenHome, fontWeight: FontWeight.bold, fontSize: 19.0)),
                              const TextSpan(text: ' Ordenes de Laboreos (OL) de nuestra firma !'),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.white38, height: 30.0),
                        ...listaWidgetEstados,
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
