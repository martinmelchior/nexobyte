


import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'ordenes_laboreo_remitar_controller.dart';


class OrdenesLaboreoRemitarPage extends GetView<OrdenesLaboreoRemitarController> {
  
  final GlobalKey<FormState> _key = GlobalKey();

  OrdenesLaboreoRemitarPage({Key? key}) : super(key: key);

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  @override
  Widget build(BuildContext context) {
    return Form(
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
            title: const Text("Remitar OL",
                style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(children: [
                      //*----------------------------------------- FORMULARIO DATOS
                      const SizedBox(height: 30.0),
                      cboTransportista(),
                      const SizedBox(height: 30.0),
                      Obx(() => cboCamion()),
                      const SizedBox(height: 30.0),
                      Obx(() => cboChofer()),
                    ]),
                  ),
                ),
              ),

              
            ],
          ),
        ));
  }

  //*------------------------------------------------------------------------------------------------------ Transportista
  Widget cboTransportista() {
    return DropdownSearch<Transportista>(
      showSearchBox: true,
      dropdownSearchDecoration: InputDecoration(
        labelText: 'TRANSPORTISTA',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      dropDownButton: _dropDownButton,
      popupBackgroundColor: Colors.white,
      maxHeight: Get.height * 0.80,
      mode: Mode.DIALOG,
      showAsSuffixIcons: true,
      itemAsString: (Transportista? i) => i!.nombre!,
      items: controller.recursosEA.transportistas,
      onChanged: (Transportista? t) => controller.setTransportista(t!),
      selectedItem: controller.getTransportista(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Camion / Chofer
  Widget cboCamion() {
    return DropdownSearch<CamionChofer>(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'CAMION  -  ACOPLADO',
              enabledBorder: _enabledBorder,
              focusedBorder: _focusedBorder,
              labelStyle: _labelStyle,
              disabledBorder: InputBorder.none,
            ),
            dropDownButton: _dropDownButton,
            popupBackgroundColor: Colors.white,
            maxHeight: Get.height * 0.8,
            mode: Mode.DIALOG,
            showAsSuffixIcons: true,
            emptyBuilder: (context, searchEntry) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/img/error.png', width: 50.0),
                  const SizedBox(height: 20.0),
                  const Text('No encontramos Camiones!\n\nSeleccione otro Transportista!',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center),
                ],
              ),
            ),
            loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
            errorBuilder: (context, searchEntry, exception) => const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text('Parece que ha ocurrido un error !',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
            ),
            onFind: (filter) async => 
              await controller.obtenerCamionesChoferes(
                    controller.ol.gEconomicoId,
                    controller.ol.empresaId,
                    controller.getTransportistaId()),
            itemAsString: (CamionChofer? c) => c!.chasisDominio! + '     ' +  c.acopladoDominio!,
            onChanged: (CamionChofer? c) => controller.setCamion(c!),
            selectedItem: controller.entidad.value.camion,
          );
  }

//*------------------------------------------------------------------------------------------------------ Chofer
  Widget cboChofer() {
    return DropdownSearch<Chofer>(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'CHOFER',
              enabledBorder: _enabledBorder,
              focusedBorder: _focusedBorder,
              labelStyle: _labelStyle,
              disabledBorder: InputBorder.none,
            ),
            dropDownButton: _dropDownButton,
            popupBackgroundColor: Colors.white,
            maxHeight: Get.height * 0.8,
            mode: Mode.DIALOG,
            showAsSuffixIcons: true,
            emptyBuilder: (context, searchEntry) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/img/error.png', width: 50.0),
                  const SizedBox(height: 20.0),
                  const Text('No encontramos Choferes!\n\nSeleccione otro Transportista!',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center),
                ],
              ),
            ),
            loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
            errorBuilder: (context, searchEntry, exception) => const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text('Parece que ha ocurrido un error !',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
            ),
            onFind: (filter) async => 
              await controller.obtenerChoferes(
                    controller.ol.gEconomicoId,
                    controller.ol.empresaId,
                    controller.getTransportistaId()),
            itemAsString: (Chofer? c) => c!.nombre!,
            onChanged: (Chofer? c) => controller.setChofer(c!),
            selectedItem: controller.entidad.value.chofer,
          );
  }
}
