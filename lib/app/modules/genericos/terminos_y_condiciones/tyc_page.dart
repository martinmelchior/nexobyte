import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'tyc_controller.dart';

class TyCPage extends  GetView<TyCController> {

  const TyCPage({Key? key}) : super(key: key);

  Future<bool> _onWillPop() async {
    return controller.onWillPop.value; //<-- SEE HERE
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.95),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: kTflexibleSpace,
            elevation: 20.0,
            iconTheme: const IconThemeData(
              color: kTIconColor, //change your color here
            ),
            title: const Text('Términos y condiciones', style: TextStyle(fontSize: 17)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                const Text('Por favor, asegúrate de leer y aceptar los siguentes términos y condiciones!', style: TextStyle(color: kTLightPrimaryColor2),),
                const SizedBox(height: 20.0),
                Obx(() => Expanded(
                  child: SingleChildScrollView(
                    child: Text(controller.textoTyC.value)))),
                Obx(() => _btnAceptarTyC()),
              ],
            ),
          )),
    );
  }

  Widget _btnAceptarTyC() {
    return Visibility(
      visible: !controller.onWillPop.value,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          width: Get.width * 0.90,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kTBackgroundColorBtnIngresarLogin),
                  elevation: MaterialStateProperty.all(15.0),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)))),
              child: const Text(
                'Acepto',
                style: TextStyle(
                  color: kTLabelColorBtnIngresarLogin,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              onPressed: () async {
                await controller.aceptarTyC();
              }),
        ),
      ),
    );
  }
}
