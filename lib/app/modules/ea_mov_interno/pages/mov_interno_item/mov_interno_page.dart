import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

import 'package:nexobyte/app/theme/app_theme.dart';

import 'mov_interno_controller.dart';

class MovInternoItemPage extends GetView<MovInternoItemController> {
  final GlobalKey<FormState> _key = GlobalKey();

  MovInternoItemPage({Key? key}) : super(key: key);

  //final UnderlineInputBorder _enabledBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  //final UnderlineInputBorder _focusedBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
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
            iconTheme: const IconThemeData(color: kTIconColor),
            title: const Text("Movimiento Interno", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
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
                      fechaDescarga(context, "Fecha de DESCARGA"),
                      const SizedBox(height: 25.0),
                      campania(),
                      const SizedBox(height: 25.0),
                      Obx(() {
                        return especie();
                      }),
                      const SizedBox(height: 25.0),
                      Obx(() {
                        return eas();
                      }),
                      const SizedBox(height: 25.0),
                      Obx(() {
                        return lotes();
                      }),
                      const SizedBox(height: 25.0),
                      Obx(() {
                        return ua();
                      }),
                      const SizedBox(height: 25.0),
                      cantidadKilos(),
                    ]),
                  ),
                ),
              ),

              //*----------------------------------------- BOTON SIGUIENTE PASO
              Expanded(
                flex: 2,
                child: Center(
                  child: Obx(() => Visibility(
                    visible: !controller.saving.value,
                    child: ElevatedButton(
                          child: SizedBox(
                            width: Get.width * 0.85,
                            child: const Text('Guardar Movimiento',
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
                            if (_key.currentState!.validate()) {
                              //-- Este save() es el que pasa los valores de las cajas de texto al controller!
                              _key.currentState!.save();
                              controller.save();
                            }
                          },
                        ),
                  )),
                ),
              )
            ],
          ),
        ));
  }

  //*------------------------------------------------------------------------------------------------------ CAMPAÑA
  Widget campania() {
    return DropdownSearch<Campania>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Seleccione la CAMPAÑA',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      itemAsString: (Campania? c) => c!.descripcion!,
      items: controller.eaResources.campanias,
      onChanged: (Campania? c) => controller.setCampania(c!, true),
      selectedItem: controller.getCampania(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ ESPECIE
  Widget especie() {
    return DropdownSearch<Especie>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Seleccione la ESPECIE',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
            child: Text(
          'No encontramos Especies para mostrar!\n\nSeleccione otra Campaña!',
          style: TextStyle(fontSize: 14),
        )),
      ),
      loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
            child: Text(
          'Parece que ocurrió un error!\n\nIntente seleccionar otra Campaña!',
          style: TextStyle(fontSize: 14),
        )),
      ),
      maxHeight: Get.height * 0.3,
      onFind: (filter) =>
          controller.obtenerEspeciesEnCampania(EAEspecieEnCampaniaRequest(
        gEconomicoId:
            controller.paramReqEAResources.gEconomicoId,
        empresaId: controller.paramReqEAResources.empresaId,
        afipCampaniaId:
            controller.rxMovimientoInternoItem.value.campania!.afipCampaniaId!,
      )),
      itemAsString: (Especie? e) => e!.nombre!,
      onChanged: (Especie? e) => controller.setEspecie(e!, true),
      selectedItem: controller.getEspecie(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ EAS
  Widget eas() {
    return DropdownSearch<ExplotacionAgropecuaria>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Seleccione la Explotación Agropecuaria',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Center(
          child: Text(
        'No hemos encontrado\nExplotaciones Agropecuarias!\n\nSeleccione una Especie/Campaña !',
        textAlign: TextAlign.center,
      )),
      loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
            child: Text(
          'Antes debe seleccionar una Especie!',
          style: TextStyle(fontSize: 14),
        )),
      ),
      maxHeight: Get.height * 0.4,
      showSearchBox: true,
      onFind: (filter) => controller.obtenerEACampaniaEspecie(
          EACampaniaEspecieRequest(
              gEconomicoId: controller.paramReqEAResources.gEconomicoId,
              empresaId:
                  controller.paramReqEAResources.empresaId,
              afipCampaniaId: controller
                  .rxMovimientoInternoItem.value.campania!.afipCampaniaId!,
              especieId: controller
                  .rxMovimientoInternoItem.value.especie!.especieId!)),
      itemAsString: (ExplotacionAgropecuaria? ea) => ea!.clienteNombre!,
      onChanged: (ExplotacionAgropecuaria? ea) => controller.setExpAgropecuaria(ea!, true),
      selectedItem: controller.getExpAgropecuaria(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ LOTES
  Widget lotes() {
    return DropdownSearch<Lote>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Seleccione el Lote',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Center(
          child: Text(
        'No hemos encontrado\nLotes para mostrar !',
        textAlign: TextAlign.center,
      )),
      loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
            child: Text(
          'Parece que ocurrió un error !',
          style: TextStyle(fontSize: 14),
        )),
      ),
      maxHeight: Get.height * 0.3,
      //showSearchBox: true,
      onFind: (filter) => controller
          .obtenerLotesPorCampaniaEspecieEA(LotesPorCampaniaEspecieEARequest(
        gEconomicoId:
            controller.paramReqEAResources.gEconomicoId,
        empresaId: controller.paramReqEAResources.empresaId,
        afipCampaniaId:
            controller.rxMovimientoInternoItem.value.campania!.afipCampaniaId!,
        especieId: controller.rxMovimientoInternoItem.value.especie!.especieId!,
        clienteId: controller.rxMovimientoInternoItem.value.ea!.clienteId!,
      )),
      itemAsString: (Lote? lo) =>
          "${lo!.loteNombre!}   ( ${lo.cantHas.toString()} )  has.",
      onChanged: (Lote? lo) => controller.setLote(lo!, false),
      selectedItem: controller.getLote(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ UAS
  Widget ua() {
    return DropdownSearch<UA>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Seleccione el ALMACENAMIENTO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      dropDownButton: _dropDownButton,
      mode: Mode.MENU,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Center(
          child: Text(
        'No hemos encontrado\nUnidades de Almacenamiento para mostrar !',
        textAlign: TextAlign.center,
      )),
      loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
            child: Text(
          'Parece que ocurrió un error !',
          style: TextStyle(fontSize: 14),
        )),
      ),
      maxHeight: Get.height * 0.3,
      //showSearchBox: true,
      onFind: (filter) => controller
          .obtenerUAsPorCampaniaEspecieEA(UAsPorCampaniaEspecieEARequest(
        gEconomicoId:
            controller.paramReqEAResources.gEconomicoId,
        empresaId: controller.paramReqEAResources.empresaId,
        afipCampaniaId:
            controller.rxMovimientoInternoItem.value.campania!.afipCampaniaId!,
        especieId: controller.rxMovimientoInternoItem.value.especie!.especieId!,
        clienteId: controller.rxMovimientoInternoItem.value.ea!.clienteId!,
      )),
      itemAsString: (UA? ua) => ua!.uaNombre!,
      onChanged: (UA? ua) => controller.setUa(ua!, false),
      selectedItem: controller.getUa(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Fecha Emision
  final textFieldFocusNodeFD = FocusNode();
  Widget fechaDescarga(BuildContext context, String label) {
    return TextFormField(
      readOnly: true,
      focusNode: textFieldFocusNodeFD,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'Fecha de Descarga',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      keyboardType: TextInputType.datetime,
      //validator: Utilidades.obligatorio,
      controller: controller.txtFechaDescargaController,
      onTap: () async {
        //*-- Deshabilito el foco!
        textFieldFocusNodeFD.unfocus();
        DateTime? _fecha = await selectDate(context, controller.movFechaDeDescarga, label, controller);
        controller.movFechaDeDescarga = _fecha ?? controller.movFechaDeDescarga;
      },
      onSaved: (value) {
        //controller.apellido = value ?? '';
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Selector de fechas
  Future<DateTime?> selectDate(BuildContext _context, DateTime? _initialDate,
      String _helpText, MovInternoItemController _controller) async {
    DateTime _inicial = _initialDate ??= DateTime.now();
    DateTime _firstDate = DateTime(
        DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

    final DateTime? picked = await showDatePicker(
        context: _context,
        initialDate: _inicial,
        firstDate: _firstDate,
        lastDate: DateTime.now(),
        helpText: _helpText.isEmpty ? 'SELECCIONE LA FECHA' : _helpText,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kTDatePickerPrimary, 
                onPrimary: kTDatePickerOnPrimary, 
                onSurface: kTDatePickerOnSurface, 
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: kTDatePickerButtons,  
                ),
              ),
            ),
            child: child!,
          );
        });

    return picked;
  }

  Widget cantidadKilos() {
    return TextFormField(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Cantidad de Kilos',
        labelStyle: _labelStyle,
        hintText: "Ingrese los kilos ...",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(7), //max length
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      controller: controller.txtCantidadController,
      onSaved: (value) {
        double c = 0.0;
        if (value!.isNotEmpty) {
          c = double.parse(value);
        }
        controller.rxMovimientoInternoItem.value.cantidad = c;
      },
    );
  }
}
