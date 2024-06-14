

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'upload_certificados_paso_2_provider.dart';

class UploadCertificadosPaso2Controller extends GetxController {

  UploadCertificadosPaso2Controller();

  final UploadCertificadosPaso2Provider _provider = Get.find<UploadCertificadosPaso2Provider>();

  Rx<bool> rxUploaded = false.obs;
  Rx<int> rxCantImagenes = 0.obs;
  List<XFile> rxImagenes = <XFile>[].obs;
  
  late CtaCteLecheResumenDeLitrosMesItem item;

  @override
  void onInit() {
    item = Get.arguments as CtaCteLecheResumenDeLitrosMesItem;
    super.onInit();
  }
  
  //*--------------------------------------------------------------- seleccionar imagenes
  Future pickImages() async {
    try {
      
      rxImagenes = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 1440,
      );

      rxCantImagenes.value = rxImagenes.length;
      rxCantImagenes.refresh();

    } catch(e) {
        String error = ApiExceptions.getCustomError(e);
        MyDialog.myShowDialog(mensaje: error.toString(), titulo: 'ERROR');
    }
  }

  //*--------------------------------------------------------------- upload certificados
  Future uploadCertificados() async {

    try {
      
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Container(
                padding: const EdgeInsets.all(20.0),
                height: Get.height * 0.25,
                child: const Column(
                  children:  [
                    SizedBox(height: 20),
                    kTCpi,
                    SizedBox(height: 20),
                    Text('Aguarde unos segundos,\nestamos procesando los certificados...', textAlign: TextAlign.center,)
                  ],
                ),
            ),
          );
        });

      await _provider.uploadCertificados(rxImagenes, item);
      //*--- Cierra el dialogo
      Navigator.of(Get.context!).pop();
      
      rxUploaded.value = true;
      
      //*------------------ Rechaza ?
      AwesomeDialog(
        dismissOnTouchOutside: false,
        dialogBackgroundColor: const Color.fromARGB(255, 233, 227, 227),
        headerAnimationLoop: false,
        context: Get.context!,
        body: const SizedBox(
          height: 200, 
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text('Listo !!!\n\nSu documentación fue recibida correctamente.\n\nLe Notificaremos cuando la misma sea procesada.\n', textAlign: TextAlign.center, style: TextStyle(color: kTAllLabelsColor, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.0, fontFamily: "Poppins")),
            )
          ),
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          btnOkText: 'Cerrar',
          btnOkColor: const Color.fromARGB(255, 60, 165, 90),
          btnOkOnPress: () {
            Get.until((route) => Get.currentRoute == AppRoutes.rResumenEntregasDeLeche);
          },
        ).show();

    } catch(e) {
        //*--- Cierra el dialogo
        Navigator.of(Get.context!).pop();
        String error = ApiExceptions.getCustomError(e);
        MyDialog.myShowDialog(mensaje: error.toString(), titulo: 'ERROR');
    }
  }
   
}