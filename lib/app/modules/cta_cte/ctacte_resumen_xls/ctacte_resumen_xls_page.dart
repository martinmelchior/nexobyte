

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'ctacte_resumen_xls_controller.dart';

class CtaCteResumenXlsPage extends GetView<CtaCteResumenXlsController> {
  
  const CtaCteResumenXlsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(color: kTIconColor),
          title: const Text("Compartir Resumen de Cta Cte", style: TextStyle(fontSize: 15.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),

    body: Stack(
          children: [
              kTBackgroundContainer,
              controller.obx(
                (state)=> SingleChildScrollView(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 50.0),
                        //*----------------------------------------------------------------- Compartir XLS
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              await Share.shareXFiles([XFile(controller.fullPath)], subject: 'Cta Cte ${controller.itemResumenCtaCte.cliente}', text: 'Compartir en formato Excel');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: kTCompartirBorderCircle, width: 8),
                                borderRadius: const BorderRadius.all(Radius.circular(80))
                              ),
                              //padding: const EdgeInsets.symmetric(vertical: 25.0),
                              width: 150,
                              height: 150,
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(Icons.share, color: kTCompartirIcono, size: 50),
                                    SizedBox(height: 10.0),
                                    Text('Compartir\nXLS', style: TextStyle(color: kTAllLabelsColor), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        //*----------------------------------------------------------------- Compartir PDF
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              await Share.shareXFiles([XFile(controller.fullPathPdf)], subject: 'Cta Cte ${controller.itemResumenCtaCte.cliente}', text: 'Compartir en formato PDF');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(117, 241, 146, 3), width: 8),
                                borderRadius: const BorderRadius.all(Radius.circular(80))
                              ),
                              width: 150,
                              height: 150,
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(Icons.share, color: Color.fromARGB(255, 241, 146, 3), size: 50),
                                    SizedBox(height: 10.0),
                                    Text('Compartir\nPDF', style: TextStyle(color: kTAllLabelsColor), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                          ),
                        )
                      ],
                  )
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Generando archivo, aguarde un momento ..'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString()),
              ),
          ]
      )
    );
  }


}

