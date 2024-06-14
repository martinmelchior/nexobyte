

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'menu_contratista_controller.dart';



class MenuContratistaPage extends GetView<MenuContratistaController> {
  
  MenuContratistaPage({Key? key}) : super(key: key);
  
  final MenuContratistaController _controller = Get.find<MenuContratistaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTScaffoldBackColorHome,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 20.0,
        title: const Text('Explotaciones Agropecuarias\nContratista', style: TextStyle(fontSize: 15.0, color: kTAllLabelsColor)),
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
                btnMovimInterno(_controller.requestEARerources, _controller.itemResumenContratista.contratistaId),
                //btnNuevaOL(_controller.requestEARerources),
                //btnPosiciones1(),
                //btnLluvias(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}


Widget btnListaOL(MenuContratistaController _c) {
  return GestureDetector(
    child: _crearBoton(assetImage: Constants.kImgOLView, label: "Mis Ordenes de Laboreos", fSize: 15, imgH: 60, imgW: 60),
    onTap: () => Get.toNamed(AppRoutes.rListaDeOLsContratista, arguments: {"itemResumenContratista": _c.itemResumenContratista, "recursosEA": _c.recursosEA}),
  );
}
Widget btnNuevaOL(EAResourcesRequest _requestEAResources) {
  return GestureDetector(
    child: _crearBoton(assetImage: Constants.kImgOLNew, label: "Nueva Orden de Laboreo", fSize: 15, imgH: 60, imgW: 60),
    onTap: () => Get.toNamed(AppRoutes.rOlPaso1, arguments: { "requestEARerources": _requestEAResources, "ordenLaboreoId": -1 }),
  );
}
Widget btnPosiciones1() {
  return GestureDetector(
    child: _crearBoton(assetImage: Constants.kImgOLView, label: "Ver todas las Ordenes de Laboreo", fSize: 15),
    onTap: () => Get.toNamed(AppRoutes.rPOSUsuarioResumen),
  );
}
Widget btnLluvias() {
  return GestureDetector(
    child: _crearBoton(assetImage: Constants.kImgRain, label: "Cargar una nueva precipitación", fSize: 15),
    onTap: () => Get.toNamed(AppRoutes.rPOSUsuarioResumen),
  );
}
Widget btnMovimInterno(EAResourcesRequest _requestEAResources, int _contratistaId) {

  final MenuContratistaController _controller = Get.find<MenuContratistaController>();
  
  return GestureDetector(
    child: _crearBoton(assetImage: Constants.kImgMovimInterno, label: "Movimientos Internos", fSize: 15, imgW: 60, imgH: 60),
    onTap: () => Get.toNamed(AppRoutes.rMovInternoList, 
                                arguments: { 
                                  "requestEARerources": _requestEAResources,  
                                  "eaResources": _controller.recursosEA,  
                                  "contratistaId": _contratistaId,  
                                }
                            ),
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