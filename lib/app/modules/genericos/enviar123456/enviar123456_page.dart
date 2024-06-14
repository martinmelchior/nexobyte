import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:nexobyte/app/utils/utils.dart';

import 'enviar123456_controller.dart';

class Enviar123456Page extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Enviar123456Page({Key? key}) : super(key: key);

  final Enviar123456Controller controller = Get.find<Enviar123456Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          kTBackgroundContainer,
          Obx(() => 
            Visibility(
              visible: !controller.newPassEnviada.value,
              child: const MyProgressIndicactor(mensaje: 'Aguarda un instante ...')
            )
          ),
          Obx(() => 
            Visibility(
              visible: controller.newPassEnviada.value,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ya te hemos asignado una nueva contraseña.\n\n\n\nAhora, por favor actualiza la App.\n\n', style: TextStyle(color: kTAllLabelsColor)),
                    TextButton(child: const Text('ACTUALIZAR', style: TextStyle(color: kTAllLabelsColor)), onPressed: () => MyDialog.openPlayStore(url: controller.url)),   
                  ],
                ),
              )
            ))
        ]));
  }
}
