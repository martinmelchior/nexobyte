import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import '../model/analisis_de_mani_model.dart';
import 'analisis_de_mani_resumen_controller.dart';



// ignore: must_be_immutable
class AnalisisDeManiResumenPage extends GetView<AnalisisDeManiResumenController> {
  
  AnalisisDeManiResumenPage({Key? key}) : super(key: key);

  late ResumenAnalisisItemResponse resumenItem;

  @override
  Widget build(BuildContext context) {

    String _titulo = "Análisis de Mani";
    
    return Scaffold(
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
                      itemCount: state!.listaResumenAnalisisItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        ResumenAnalisisItem itemResumenAnalisis = state.listaResumenAnalisisItem[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child: ShowResumenItem(itemResumenAnalisis: itemResumenAnalisis),
                        );
                      }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Armando resumen de análisis !'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString()),
              ),
          ]
        ));
  }
}


// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowResumenItem extends StatelessWidget {

  final AnalisisDeManiResumenController controller = Get.find<AnalisisDeManiResumenController>();
  final ResumenAnalisisItem itemResumenAnalisis;

  ShowResumenItem({
    Key? key,
    required this.itemResumenAnalisis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.rAnalisisLista, arguments: { "itemResumenAnalisis": itemResumenAnalisis }),
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
                        Text(itemResumenAnalisis.clienteProductor, style: const TextStyle(fontSize: 16.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2.0),
                        Text(itemResumenAnalisis.empresa, style: const TextStyle(fontSize: 12.0, color: kTAppBarTextColor)),
                        const SizedBox(height: 8.0),
                        Text('${itemResumenAnalisis.cantidad.toString()}  análisis !', style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: kTCompartirIcono)),
                        const SizedBox(height: 8.0),
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
