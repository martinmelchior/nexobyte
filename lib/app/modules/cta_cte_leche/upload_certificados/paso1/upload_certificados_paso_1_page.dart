import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'upload_certificados_paso_1_controller.dart';

class UploadCertificadosPaso1Page
    extends GetView<UploadCertificadosPaso1Controller> {
  const UploadCertificadosPaso1Page({Key? key}) : super(key: key);

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
          title: const Text("Enviar Certificados", style: TextStyle(fontSize: 18, fontFamily: 'Sora', color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                    'Si continuas, deberías subir certificados correspondientes al tambo:\n'),
                Text(controller.item.tambo,
                    style: const TextStyle(color: kTLabelTextBoxLogin, fontSize: 18)),
                const SizedBox(height: 20.0),
                const Text(
                    'Antes de subir o enviarnos los certificados de BRUCELOSIS o TUBERCULOSIS, por favor siga las siguientes instrucciones:\n\n'),
                const Text(
                    '1 - Tome fotos de los certificados a hoja completa, no envíe imágenes parciales de los certificados. Estas serán rechazadas.\n'),
                const Text(
                    '2 - Una vez haya tomado las fotos, continúe con el PASO 2, el cuál le permitirá seleccionar las imágenes y enviarlas.\n'),
                const Text(
                    '3 - En el PASO 2 deberias seleccionar todas las FOTOS DE LOS CERTIFICADOS y enviarlas en una sola acción.\n'),
                const SizedBox(height: 30.0),
                Obx(() => Visibility(
                      visible: controller.rxTieneSubidaPendientes.value,
                      child: Column(
                        children: [
                          Container(
                            decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color: kTRedColor.withOpacity(0.8),
                            ),
                            padding: const EdgeInsets.all(15.0),
                            child: const Text(
                                'Ya enviaste certificados que están pendientes de aprobar, por favor, continúa con el Paso 2 solo si vas a enviar información nueva.\n',
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 40.0),
                        ],
                      ),
                    )),
                ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.rUploadCertPaso2,
                        arguments: controller.item),
                    child: SizedBox(
                      width: Get.width * 0.85,
                      child: const Text('Continuar  -  Paso 2',
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)))))
              ],
            ),
          ),
        ));
  }
}
