import 'package:nexobyte/app/modules/lluvias/model/lluvias_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';

import 'lluvias_list_controller.dart';


class LluviasListPage extends GetView<LluviasListController> {
  
  LluviasListPage({Key? key}) : super(key: key);

  Lluvia lluvia = Lluvia();
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
              bool reloadList = await Get.toNamed(AppRoutes.rLluviasItem, 
                                                                arguments: { 
                                                                  "resumenDeIngenieroItem": controller.request,
                                                                  "recursosEA":              controller.recursosEA,
                                                                  "lluviaId": -1 });
              if (reloadList)
              {
                await controller.obtenerLluvias();
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
          title: const Text("Registro de Lluvias", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              controller.obx(
                (state) =>  RefreshIndicator(
                  color: kTLabelEspecieResumenHome,
                  backgroundColor: kTLightPrimaryColor3,
                  onRefresh: () async => await controller.obtenerLluvias(),
                  child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state!.lluvias.length,
                        itemBuilder: (BuildContext context, int index) {
                          lluvia = state.lluvias[index];
                          registro++;
                          return ShowLluviasItem(lluvia: lluvia, registro: registro);
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
class ShowLluviasItem extends StatelessWidget {

  final LluviasListController _controller = Get.find<LluviasListController>();

  final Lluvia lluvia;
  final int registro;

  ShowLluviasItem({
    Key? key,
    required this.lluvia,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 1,
                            child: Text(DateFormat("dd-MM-yyyy").format(lluvia.fecha!), style: const TextStyle(fontSize: 13, color: Colors.black54)),
                          ),
                          Expanded(flex: 1, child: Text("${numberFormat.format(lluvia.precipitacion)} mm", textAlign: TextAlign.end, style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text(lluvia.lluviaId.toString(), style: const TextStyle(fontSize: 13, color: Colors.black87)),
                                  Text(lluvia.ea!.clienteNombre!, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                                  const SizedBox(height: 3.0),
                                  Text(lluvia.campania!.descripcion!, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                                  const SizedBox(height: 3.0),
                                  Text(lluvia.userName!, style: const TextStyle(fontSize: 12, color: kTLightPrimaryColor3)),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: lluvia.permiteEliminar ?? false,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => Get.dialog(
                                    AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Row(
                                        children:  [
                                          Text('ATENCION', style: TextStyle(fontSize: 16, color: kTAllLabelsColor)),
                                        ],
                                      ),
                                      titleTextStyle: const TextStyle(fontSize: 18, color: kTLightPrimaryColor1),
                                      content: Text("Eliminas la lluvia de:\n\n${numberFormat.format(lluvia.precipitacion)} mm ?", style: const TextStyle(color: Colors.black87)),
                                      contentTextStyle: const TextStyle(fontSize: 16, color: kTLightPrimaryColor1),
                                      actions: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red, // background
                                                foregroundColor: Colors.white, // foreground
                                              ),
                                              onPressed: () async {
                                                await _controller.eliminarLluvia(lluvia, context);
                                              },
                                              child: const Text('SI'),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black38, // background
                                                foregroundColor: Colors.white, // foreground
                                              ),
                                              onPressed: () => Get.back(),
                                              child: const Text('NO'),
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                    barrierDismissible: false,
                                  ),
                                  child: const Icon(Icons.close, size: 25, color: Colors.black26)),
                              ),
                            ),
                            
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
