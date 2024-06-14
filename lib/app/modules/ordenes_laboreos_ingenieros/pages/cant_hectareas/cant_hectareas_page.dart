

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'cant_hectareas_controller.dart';

class CantHectareasPage extends GetView<CantHectareasController> {
  
  const CantHectareasPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _key = GlobalKey();

    return Scaffold(
    appBar: AppBar(title: const Text('Cant. Has a Trabajar', style: TextStyle(color: kTAllLabelsColor))),

    body: SafeArea(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _key,
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.95),
          appBar: AppBar(
            flexibleSpace: kTflexibleSpace,
            elevation: 10.0,
            backgroundColor: kTLightPrimaryColor,
            iconTheme: const IconThemeData(
              color: kTIconColor, //change your color here
            ),
            title: const Text("Definir Has a Trabajar",
                style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                    child: Column(children: [
                      Obx(() => const Text('')),
                      const SizedBox(height: 25.0),
                    ]),
                  ),
                ),
              ),
              
              //*----------------------------------------- BOTON SIGUIENTE PASO
              Expanded(
                flex: 1,
                child: Center(
                  child: Obx(() => ElevatedButton(
                          child: SizedBox(
                            width: Get.width * 0.85,
                            child: const Text('Guardar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kTLabelColorBtnIngresarLogin,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                )),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  kTBackgroundColorBtnIngresarLogin),
                              elevation: MaterialStateProperty.all(15.0),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15.0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          onPressed: () async {
                            // if (_key.currentState!.validate()) {
                            //   //-- Este save() es el que pasa los valores de las cajas de texto al controller!
                            //   _key.currentState!.save();
                            //   if (controller.mode == FormMode.insert)
                            //   {
                            //     controller.saveInsert();
                            //   }
                            // }
                          },
                        ),
                  )),
                ),
            ],
          ),
        )
      )
    ));
  }


  
}