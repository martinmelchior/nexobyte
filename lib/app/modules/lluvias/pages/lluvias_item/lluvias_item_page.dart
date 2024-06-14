


import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'lluvias_item_controller.dart';


class LluviasItemPage extends GetView<LluviasItemController> {
  
  final GlobalKey<FormState> _key = GlobalKey();

  LluviasItemPage({Key? key}) : super(key: key);

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
            title: const Text("Registrar Lluvia",
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
                      campania(),
                      const SizedBox(height: 30.0),
                      fecha(context, "Fecha"),
                      const SizedBox(height: 30.0),
                      Obx(() {
                        return eas();
                      }),
                      const SizedBox(height: 30.0),
                      cantidadMM(),
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
                            child: const Text('Guardar registro de lluvia',
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
      dropdownButtonBuilder: (context) => const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 40),
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
      items: controller.recursosEA.campanias,
      onChanged: (Campania? c) => controller.setCampania(c!, true),
      selectedItem: controller.getCampania(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ EAS
  Widget eas() {
    return DropdownSearch<ExplotacionAgropecuaria>(
      dropdownButtonBuilder: (context) => const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 40),
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
        child: Text('No hemos encontrado\nExplotaciones Agropecuarias!\n\nSeleccione una Campaña !',
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
      onFind: (filter) => controller.obtenerEACampania(
          EACampaniaRequest(
              gEconomicoId: controller.resumenDeIngenieroItem.gEconomicoId,
              empresaId: controller.resumenDeIngenieroItem.empresaId,
              afipCampaniaId: controller.rxLluviaItem.value.campania!.afipCampaniaId!,
            )),
      itemAsString: (ExplotacionAgropecuaria? ea) => ea!.clienteNombre!,
      onChanged: (ExplotacionAgropecuaria? ea) => controller.setExpAgropecuaria(ea!, true),
      selectedItem: controller.getExpAgropecuaria(),
    );
  }


  //*------------------------------------------------------------------------------------------------------ Fecha
  final textFieldFocusNodeFD = FocusNode();
  Widget fecha(BuildContext context, String label) {
    return TextFormField(
      readOnly: true,
      focusNode: textFieldFocusNodeFD,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'Fecha',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
      ),
      keyboardType: TextInputType.datetime,
      //validator: Utilidades.obligatorio,
      controller: controller.txtFechaController,
      onTap: () async {
        //*-- Deshabilito el foco!
        textFieldFocusNodeFD.unfocus();
        DateTime? _fecha = await selectDate(context, controller.getFecha, label, controller);
        controller.setFecha = _fecha ?? controller.getFecha;
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Selector de fechas
  Future<DateTime?> selectDate(BuildContext _context, DateTime? _initialDate,
      String _helpText, LluviasItemController _controller) async {
    DateTime _inicial = _initialDate ??= DateTime.now();
    DateTime _firstDate = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);

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
                  foregroundColor: kTDatePickerButtons, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    return picked;
  }

  Widget cantidadMM() {
    return TextFormField(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Cantidad de milímetros',
        labelStyle: _labelStyle,
        hintText: "Ingrese los milímetros ...",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(3), //max length
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      controller: controller.txtCantidadController,
      onSaved: (value) {
        int c = 0;
        if (value!.isNotEmpty) {
          c = int.parse(value);
        }
        controller.rxLluviaItem.value.precipitacion = c;
      },
    );
  }
}
