import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'ordenes_laboreo_filtros_ing_controller.dart';

class OrdenesLaboreoFiltrosIngPage extends GetView<OrdenesLaboreoFiltrosIngController> {

  OrdenesLaboreoFiltrosIngPage({Key? key}) : super(key: key);


  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 14);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  Icon iconArrowDown = const Icon(Icons.arrow_drop_down_sharp, color: Colors.black45, size: 35);
  Icon iconClearButton = const Icon(Icons.clear, color: Colors.black45);

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
          title: const Text("Filtrar Ordenes de Laboreos",
              style: TextStyle(fontSize: 16.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ver solo mis OLs', style: TextStyle(color: kTLightPrimaryColor)),
                    Obx(() => Switch(
                        value: controller.filtrosOLs.value.verSoloMisOLs,
                        onChanged: (valor) {
                            controller.filtrosOLs.value.ingenieroId = valor ? controller.itemResumenIngeniero.ingenieroId : 0;
                            controller.filtrosOLs.value.verSoloMisOLs = valor;
                            controller.filtrosOLs.refresh();
                          })
                      ),
                  ],
                ),
                const SizedBox(height: 30.0),
                _campania(),
                const SizedBox(height: 30.0),
                _eas(),
                const SizedBox(height: 30.0),
                _contratistas(),
                const SizedBox(height: 30.0),
                _especie(),
                const SizedBox(height: 30.0),
                _labores(),
                const SizedBox(height: 100.0),
                BtnAplicarFiltro(controller: controller),
                const SizedBox(height: 200.0),
              ],
            ),
          ),
        )));
  }


  //*------------------------------------------------------------------------------------------------------ CAMPAÑA
  _campania() {
    return DropdownSearch<Campania>(
      showClearButton: true,
      clearButton: iconClearButton,
      dropdownButtonBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: iconArrowDown,
      ),
      dropdownSearchDecoration: InputDecoration( 
        labelText: 'Campaña', 
        enabledBorder: _enabledBorder, 
        focusedBorder: _focusedBorder, 
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      itemAsString: (Campania? c) => c!.descripcion!,
      items: controller.recursosEA.campanias,
      selectedItem: controller.filtrosOLs.value.campania,
      onChanged: (Campania? c) => controller.filtrosOLs.value.campania = c
    );
  }

  //*------------------------------------------------------------------------------------------------------ EAS
  _eas() {
    return DropdownSearch<ExplotacionAgropecuaria>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Explotación Agropecuaria',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      showClearButton: true,
      clearButton: iconClearButton,
      dropdownButtonBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: iconArrowDown,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Center( child: Text( 'No hemos encontrado\nExplotaciones Agropecuarias!', textAlign: TextAlign.center,
      )),
      loadingBuilder: (context, searchEntry) => const Center(child: Column(
        children: [
          SizedBox(height: 20.0),
          Text('Aguarde un momento', style: TextStyle(color: Colors.black45)),
          SizedBox(height: 20.0),
          kTCpi,
        ],
      )),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center( child: Text( 'Ooops parece que ocurrió un error!', style: TextStyle(fontSize: 14))),
      ),
      maxHeight: Get.height * 0.4,
      showSearchBox: true,
      onFind: (filter) => controller.obtenerEAPredictivo(),
      itemAsString: (ExplotacionAgropecuaria? ea) => ea!.clienteNombre!,
      selectedItem: controller.filtrosOLs.value.ea,
      onChanged: (ExplotacionAgropecuaria? ea) => controller.filtrosOLs.value.ea = ea,
    );
  }

  //*------------------------------------------------------------------------------------------------------ ESPECIE
  _especie() {
    return DropdownSearch<Especie>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Especie',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      showClearButton: true,
      clearButton: iconClearButton,
      dropdownButtonBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: iconArrowDown,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Center( child: Text( 'No hemos encontrado especies!', textAlign: TextAlign.center,
      )),
      loadingBuilder: (context, searchEntry) => const Center(child: Column(
        children: [
          SizedBox(height: 20.0),
          Text('Aguarde un momento', style: TextStyle(color: Colors.black45)),
          SizedBox(height: 20.0),
          kTCpi,
        ],
      )),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center( child: Text( 'Ooops parece que ocurrió un error!', style: TextStyle(fontSize: 14))),
      ),
      maxHeight: Get.height * 0.4,
      showSearchBox: true,
      onFind: (filter) => controller.obtenerEspeciesEnCampania(),
      itemAsString: (Especie? e) => e!.nombre!,
      selectedItem: controller.filtrosOLs.value.especie,
      onChanged: (Especie? e) => controller.filtrosOLs.value.especie = e,
    );
  }

  //*------------------------------------------------------------------------------------------------------ CAMPAÑA
  _labores() {
    return DropdownSearch<Laboreo>(
      showClearButton: true,
      clearButton: iconClearButton,
      dropdownButtonBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: iconArrowDown,
      ),
      dropdownSearchDecoration: InputDecoration( 
        labelText: 'Labor', 
        enabledBorder: _enabledBorder, 
        focusedBorder: _focusedBorder, 
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      maxHeight: Get.height * 0.4,
      showSearchBox: true,
      itemAsString: (Laboreo? l) => l!.laboreo!,
      items: controller.recursosEA.laboreos,
      selectedItem: controller.filtrosOLs.value.laboreo,
      onChanged: (Laboreo? l) => controller.filtrosOLs.value.laboreo = l
    );
  }

  //*------------------------------------------------------------------------------------------------------ CONTRATISTAS
  _contratistas() {
    return DropdownSearch<Contratista>(
      showClearButton: true,
      clearButton: iconClearButton,
      dropdownButtonBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: iconArrowDown,
      ),
      dropdownSearchDecoration: InputDecoration( 
        labelText: 'Contratista', 
        enabledBorder: _enabledBorder, 
        focusedBorder: _focusedBorder, 
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      maxHeight: Get.height * 0.4,
      showSearchBox: true,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      itemAsString: (Contratista? c) => c!.nombre!,
      items: controller.recursosEA.contratistas,
      selectedItem: controller.filtrosOLs.value.contratista,
      onChanged: (Contratista? c) => controller.filtrosOLs.value.contratista = c
    );
  }

}

//*------------------------------------------------------------------------------------------------------ EAS
class BtnAplicarFiltro extends StatelessWidget {
  const BtnAplicarFiltro({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final OrdenesLaboreoFiltrosIngController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: SizedBox(
          width: Get.width * 0.85,
          child: const Text('Aplicar Filtros',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTLabelColorBtnIngresarLogin,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              )),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kTBackgroundColorBtnIngresarLogin),
            elevation: MaterialStateProperty.all(15.0),
            padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)))),
        onPressed: () {

          if (controller.pageIsValid())
          {
            //*-- El result es la etidad filtro
            Get.back(result: controller.filtrosOLs);
          }
          else
          {
            Get.showSnackbar(const GetSnackBar(
              title: 'ATENCION',
              message: 'No seleccionaste ningún filtro para realizar!',
              duration: Duration(seconds: 2),));
          }
        }
      );
  }
}
