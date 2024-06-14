import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'orden_laboreo_item_paso_1_controller.dart';
import 'orden_laboreo_item_paso_2_controller.dart';

class OrdenLaboreoItemPaso2 extends GetView<OrdenLaboreoItemPaso2Controller> {
  OrdenLaboreoItemPaso2({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey();

  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final TextStyle _labelStyle =
      const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

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
            //!-- Add Cerrar OL
            title: Text(controller.mode == FormMode.insert 
                                ? "Nueva Orden de Laboreo\nPaso  2"
                                : controller.accion == "CERRAR"
                                    ? "Cerrar Orden de Laboreo"
                                    : "Edición de\nOrden de Laboreo",
                style: TextStyle(fontSize: 17.0, color: controller.accion == "CERRAR" 
                                                                ? Colors.yellow[100]
                                                                : kTAllLabelsColor)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30.0),
                    child: Column(children: [
                      Obx(() => _contratista()),
                      const SizedBox(height: 25.0),
                      Obx(() => _labores()),
                      const SizedBox(height: 25.0),
                      Obx(() => Row(
                            children: [
                              Expanded(child: _cotizacion()),
                              const SizedBox(width: 20),
                              SizedBox(width: Get.width * 0.46),
                              //Expanded(child: _masCotizaciones()),
                            ],
                          )),
                      const SizedBox(height: 25.0),
                      Obx(() => Row(
                            children: [
                              Expanded(child: _precioHaPES()),
                              const SizedBox(width: 20),
                              Expanded(child: _precioHaDOL()),
                            ],
                          )),
                      const SizedBox(height: 25.0),
                      Obx(() => _observacion()),
                      const SizedBox(height: 25.0),
                    ]),
                  ),
                ),
              ),

              //*----------------------------------------- BOTON SIGUIENTE PASO
              Expanded(
                flex: 1,
                child: Center(
                  child: Obx(() => Visibility(
                        visible: !controller.saving.value,
                        child: ElevatedButton(
                          child: SizedBox(
                            width: Get.width * 0.85,
                            child: const Text('Siguiente  -  Paso 3',
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
                              controller.goPaso3();
                            }
                          },
                        ),
                      )),
                ),
              ),
            ],
          ),
        ));
  }

  //*------------------------------------------------------------------------------------------------------ Ingeniero
  Widget _contratista() {

    //!-- Add Remitar OL
    final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) {
      enabled = true;
    } 
    else if (controllerP1.mode == FormMode.update) {
      //!-- Add Cerrar OL
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE" || (controllerP1.rxOLAbm.value.estado == "REMITADO" && controllerP1.accion != "CERRAR");
    }

    return DropdownSearch<Contratista>(
      //!-- Add Remitar OL
      enabled: enabled,
      dropdownSearchDecoration: InputDecoration(
        labelText: 'CONTRATISTA',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      dropDownButton: _dropDownButton,
      popupBackgroundColor: Colors.white,
      maxHeight: Get.height * 0.90,
      showSearchBox: true,
      mode: Mode.DIALOG,
      showAsSuffixIcons: true,
      itemAsString: (Contratista? c) => c!.nombre!,
      items: controller.recursosEAController.recursosEA.contratistas,
      onChanged: (Contratista? c) => controller.setContratista(c!),
      selectedItem: controller.getContratista(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Labores
  Widget _labores() {
    
    //!-- Add Remitar OL
    final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) {
      enabled = true;
    } 
    else if (controllerP1.mode == FormMode.update) {
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE";
    }

    return DropdownSearch<Laboreo>(
      enabled: enabled,
      dropdownSearchDecoration: InputDecoration(
        labelText: 'LABOREO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      dropDownButton: _dropDownButton,
      popupBackgroundColor: Colors.white,
      maxHeight: Get.height * 0.90,
      showSearchBox: true,
      mode: Mode.DIALOG,
      showAsSuffixIcons: true,
      itemAsString: (Laboreo? l) => l!.laboreo!,
      items: controller.recursosEAController.recursosEA.laboreos,
      onChanged: (Laboreo? l) => controller.setLaboreo(l!),
      selectedItem: controller.getLaboreo(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Cotizacion
  Widget _cotizacion() {

    //!-- Add Remitar OL
    final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) {
      enabled = true;
    } 
    else if (controllerP1.mode == FormMode.update) {
      //!-- Add Cerrar OL
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE" || (controllerP1.rxOLAbm.value.estado == "REMITADO" && controllerP1.accion != "CERRAR");
    }

    return Focus(
      focusNode: controller.txtFocusCotizacion,
      child: TextFormField(
        //!-- Add Remitar OL
        enabled: enabled,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          disabledBorder: InputBorder.none,
          labelText: 'COTIZ. DOLAR',
          suffixText: r"  $ AR",
          labelStyle: _labelStyle,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(6), //max length
          CommaTextInputFormatter(),
          //FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        controller: controller.txtCotizacionController.value,
      ),
    );
  }

  //*------------------------------------------------------------------------------------------------------ mas cotizaciones
  Widget _masCotizaciones() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87, // background
        foregroundColor: Colors.white, // foreground
      ),
      onPressed: () {},
      child: const Text('Ver Cotizaciones'),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Precio en PESOS
  Widget _precioHaPES() {

    //!-- Add Remitar OL
    final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) {
      enabled = true;
    } 
    else if (controllerP1.mode == FormMode.update) {
      //!-- Add Cerrar OL
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE" || (controllerP1.rxOLAbm.value.estado == "REMITADO" && controllerP1.accion != "CERRAR");
    }

    return Focus(
      focusNode: controller.txtFocusPesos,
      child: TextFormField(
        //!-- Add Remitar OL
        enabled: enabled,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          disabledBorder: InputBorder.none,
          labelText: '\$ / ha',
          suffixText: r"  $ AR",
          labelStyle: _labelStyle,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(8), //max length
          CommaTextInputFormatter(),
          //FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        controller: controller.txtPrecioHaPesos.value,
      ),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Precio en PESOS
  Widget _totalPES() {

    return TextFormField(
      readOnly: true,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black87,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Total \$',
        suffixText: r"  $ AR",
        labelStyle: _labelStyle,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      controller: controller.txtTotalPesosController.value,
    );
  }

  //*------------------------------------------------------------------------------------------------------ Precio en DOLARES
  Widget _precioHaDOL() {

    //!-- Add Remitar OL
    final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) {
      enabled = true;
    } 
    else if (controllerP1.mode == FormMode.update) {
      //!-- Add Cerrar OL
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE" || (controllerP1.rxOLAbm.value.estado == "REMITADO" && controllerP1.accion != "CERRAR");
    }

    return Focus(
      focusNode: controller.txtFocusDolar,
      child: TextFormField(
        //!-- Add Remitar OL
        enabled: enabled,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          disabledBorder: InputBorder.none,
          labelText: 'US\$ / ha',
          suffixText: r"  US$",
          labelStyle: _labelStyle,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(8), //max length
          CommaTextInputFormatter(),
          //FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        controller: controller.txtPrecioHaDolar.value,
      ),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Precio en OBSERVACION
  Widget _observacion() {
    final OrdenLaboreoItemPaso1Controller controllerP1 =
        Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) {
      enabled = true;
    } else if (controllerP1.mode == FormMode.update) {
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE";
    }

    return Focus(
      focusNode: controller.txtFocusObservacion,
      child: TextFormField(
        enabled: enabled,
        minLines: 2,
        maxLines: 5,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelText: 'OBSERVACION',
          labelStyle: _labelStyle,
          disabledBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
        controller: controller.txtObservacion.value,
        onSaved: (c) {
          //controller.setCotizacion(double.parse(c!));
        },
      ),
    );
  }
}
