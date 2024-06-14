import 'dart:io';

import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'upload_certificados_paso_2_controller.dart';

class UploadCertificadosPaso2Page extends GetView<UploadCertificadosPaso2Controller> {
  const UploadCertificadosPaso2Page({Key? key}) : super(key: key);

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
          title: const Text("Seleccione la imágenes\na enviar", style: TextStyle(fontSize: 18, fontFamily: 'Sora', color: kTAllLabelsColor)),
          centerTitle: true,
        ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('Si continuas, deberías subir certificados correspondientes al tambo:\n'),
                    Text(controller.item.tambo, style: const TextStyle(color: kTLabelTextBoxLogin, fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed: () async {
                    await controller.pickImages();
                  },
                  child: SizedBox(
                    width: Get.width * 0.85,
                    child: const Text('Abrir Galería de Fotos',
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))))),

              const SizedBox(height: 20.0),

              //*---------------------- muestro imagenes seleccionadas
              Obx(() => Visibility(
                    visible: controller.rxCantImagenes > 0,
                    child: Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.all(20.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: controller.rxImagenes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GridTile(
                                child: Image.file(
                                    File(controller.rxImagenes[index].path)));
                          }),
                    ),
                  )),

              //*---------------------- subir certificados
              Obx(() => Visibility(
                    visible: controller.rxCantImagenes > 0 && !controller.rxUploaded.value,
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.uploadCertificados();
                        },
                        child: SizedBox(
                          width: Get.width * 0.85,
                          child: const Text('Enviar Certificados',
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
                                    borderRadius: BorderRadius.circular(30.0))))),
                  )),

              const SizedBox(height: 20.0),
            ],
          ),
      ),
    );
  }
}
