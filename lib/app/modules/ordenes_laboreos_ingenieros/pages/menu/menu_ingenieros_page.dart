

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'menu_ingenieros_controller.dart';



class MenuIngenieroPage extends GetView<MenuIngenierosController> {
  
  MenuIngenieroPage({Key? key}) : super(key: key);
  
  final MenuIngenierosController _controller = Get.find<MenuIngenierosController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTScaffoldBackColorHome,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 20.0,
        title: const Text('Explotaciones Agropecuarias\nIngeniero', style: TextStyle(fontSize: 15.0, color: kTAllLabelsColor)),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
      ),
      body: Stack(children: [
        kTBackgroundContainer,
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                btnListaOL(_controller),
                btnMovimInterno(_controller.requestEARerources),
                btnNuevaOL(_controller.requestEARerources, _controller.itemResumen),
                //btnPosiciones1(),
                btnLluvias(_controller),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}


Widget btnListaOL(MenuIngenierosController _c) {
  return Column(
    children: [
      GestureDetector(
        child: _crearBoton(assetImage: Constants.kImgOLView, label: "Consultar todas las Ordenes de Laboreos", fSize: 15, imgH: 60, imgW: 60),
        onTap: () => Get.toNamed(AppRoutes.rListaDeOLsIngeniero, arguments: {"itemResumenIngeniero": _c.itemResumen, "recursosEA": _c.recursosEA }),
      ),
      const SizedBox(height: 10.0)
    ],
  );
}

Widget btnNuevaOL(EAResourcesRequest _requestEAResources, OrdenesLaboreosResumenDeIngenieroItem itemResumen) {
  return Column(
    children: [
      GestureDetector(
        child: _crearBoton(assetImage: Constants.kImgOLNew, label: "Nueva Orden de Laboreo", fSize: 15),
        onTap: () => Get.toNamed(AppRoutes.rOlPaso1, 
          arguments: { 
            "requestEARerources": _requestEAResources, 
            "ordenLaboreoId": -1,
            "itemResumen": itemResumen,     //-- Agrgegado 20/09 para predefinir el ingeniero
          }
        ),
      ),
      const SizedBox(height: 10.0)
    ],
  );
}
Widget btnPosiciones1() {
  return Column(
    children: [
      GestureDetector(
        child: _crearBoton(assetImage: Constants.kImgOLView, label: "Ver todas las Ordenes de Laboreo", fSize: 15),
        onTap: () => Get.toNamed(AppRoutes.rPOSUsuarioResumen),
      ),
      const SizedBox(height: 10.0)
    ],
  );
}
Widget btnLluvias(MenuIngenierosController _c) {
  return Column(
    children: [
      GestureDetector(
        child: _crearBoton(assetImage: Constants.kImgRain, label: "Registro de Lluvias", fSize: 15),
        onTap: () => Get.toNamed(AppRoutes.rLluviasList, arguments: {"itemResumenIngeniero": _c.itemResumen, "recursosEA": _c.recursosEA}),
      ),
      const SizedBox(height: 10.0)
    ],
  );
}

Widget btnMovimInterno(EAResourcesRequest _requestEAResources) {

  final MenuIngenierosController _controller = Get.find<MenuIngenierosController>();

  return Column(
    children: [
      GestureDetector(
        child: _crearBoton(assetImage: Constants.kImgMovimInterno, label: "Movimientos Internos", fSize: 15, imgW: 60, imgH: 60),
        onTap: () => Get.toNamed(AppRoutes.rMovInternoList, 
                                    arguments: { 
                                      "requestEARerources": _requestEAResources, 
                                      "eaResources": _controller.recursosEA,  
                                    }),
      ),
      const SizedBox(height: 10.0)
    ],
  );
}

//------------------------------------------------------------------------------------------------- _crearBoton
Widget _crearBoton({String assetImage = '', String label = '', double fSize = 15, double imgW = 70.0, double imgH = 70.0}) {
  return  Container(
      width: Get.width * 0.95,
      color: Colors.transparent,
      child: Card(
        color: kTBackgroundBtnHome,
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: Get.width * 0.33,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(assetImage, width: imgW, height: imgH),
                const SizedBox(width: 20.0),
                Expanded(
                  child: SizedBox(
                    child: Text(label,
                        style: TextStyle(
                            fontSize: fSize,
                            fontWeight: FontWeight.bold,
                            color: kTLabelBtnHome)),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
  );
}