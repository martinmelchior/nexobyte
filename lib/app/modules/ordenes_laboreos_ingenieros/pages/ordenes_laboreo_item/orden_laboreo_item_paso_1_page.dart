import 'package:dropdown_search/dropdown_search.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_1_controller.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';

class OrdenLaboreoItemPaso1 extends GetView<OrdenLaboreoItemPaso1Controller> {

  OrdenLaboreoItemPaso1({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey();

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
            iconTheme: const IconThemeData(
              color: kTIconColor, //change your color here
            ),
            //!-- Add Cerrar OL
            title: Text(controller.mode == FormMode.insert 
                                ? "Nueva Orden de Laboreo\nPaso  1"
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
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(child: Obx(() =>_nroOL())),
                          const SizedBox(width: 30),
                          Expanded(child: _estado()),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Obx(() => _campania(controller.mode)),
                      const SizedBox(height: 25.0),
                      //Obx(() => _especie()),
                      //const SizedBox(height: 25.0),
                      Row(
                        children: [
                          Obx(() => Expanded(child: _fechaEmi(context, 'FECHA DE EMISION'))),
                          const SizedBox(width: 15),
                          Obx(() => Expanded(child: _fechaVto(context, 'FECHA DE VENCIMIENTO'))),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Obx(() => _ingeniero()),
                      const SizedBox(height: 25.0),
                      Obx(() => _eas(controller.mode)),
                      const SizedBox(height: 25.0),
                      Obx(() => _uaOrigen(controller.mode)),
                      const SizedBox(height: 25.0),
                      Obx(() => _uaDestino(controller.mode)),
                    ]),
                  ),
                ),
              ),
              // ),

              //*----------------------------------------- BOTON SIGUIENTE PASO
              Expanded(
                flex: 1,
                child: Center(
                  child: Obx(() => Visibility(
                    visible: !controller.saving.value,
                    child: ElevatedButton(
                          child: SizedBox(
                            width: Get.width * 0.85,
                            child: const Text('Siguiente  -  Paso 2',
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
                              controller.goPaso2();
                            }
                          },
                        ),
                  )),
                ),
              ),

              //*----------------------------------------- BOTON SIGUIENTE PASO
              // Expanded(
              //   flex: 1,
              //   child: Center(
              //     child: MaterialButton(
              //       minWidth: Get.width * 0.95,
              //       color: kTLightPrimaryColor2,
              //       textColor: kTAllLabelsColor,
              //       child: const Icon(Icons.arrow_forward_ios_outlined),
              //       onPressed: () => Get.toNamed(AppRoutes.rOlPaso2),
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }

  //*------------------------------------------------------------------------------------------------------ Nro de OL
  Widget _nroOL() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        labelText: 'OL NRO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(20),
      ],
      keyboardType: TextInputType.number,
      //validator: Utilidades.obligatorio,
      controller: controller.txtOrdenLaboreoIdController.value,
      onSaved: (value) {
        //controller.rxOLAbm.value.olId = int.parse(value.toString());
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Estado
  Widget _estado() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        labelText: 'ESTADO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      controller: controller.txtEstadoController,
      onSaved: (value) {
        //controller.apellido = value ?? '';
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Campaña
  Widget _campania(FormMode mode) {
    return DropdownSearch<Campania>(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'CAMPAÑA',
              enabledBorder: _enabledBorder,
              focusedBorder: _focusedBorder,
              labelStyle: _labelStyle,
              disabledBorder: InputBorder.none,
            ),
            dropDownButton: _dropDownButton,
            popupBackgroundColor: Colors.white,
            maxHeight: Get.height * 0.4,
            enabled: mode == FormMode.insert ? true : false,
            mode: Mode.DIALOG,
            showAsSuffixIcons: true,
            itemAsString: (Campania? c) => c!.descripcion!,
            items: controller.recursosEAController.recursosEA.campanias,
            onChanged: (Campania? c) => controller.setCampania(c!, true),
            selectedItem: controller.getCampania(),
          );
  }

  
  //*------------------------------------------------------------------------------------------------------ Ingeniero
  Widget _ingeniero() {

    final OrdenLaboreoItemPaso1Controller controller = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controller.mode == FormMode.insert) { 
      enabled = true; 
    }
    else if (controller.mode == FormMode.update) { 
      enabled = controller.rxOLAbm.value.estado == "PENDIENTE"; 
    }

    return DropdownSearch<Ingeniero>(
      enabled: enabled,
      dropdownSearchDecoration: InputDecoration(
        labelText: 'INGENIERO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      dropDownButton: _dropDownButton,
      popupBackgroundColor: Colors.white,
      maxHeight: Get.height * 0.50,
      mode: Mode.DIALOG,
      showAsSuffixIcons: true,
      itemAsString: (Ingeniero? i) => i!.nombre!,
      items: controller.recursosEAController.recursosEA.ingenieros,
      onChanged: (Ingeniero? i) => controller.setIngeniero(i!),
      selectedItem: controller.getIngeniero(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ EAS
  Widget _eas(FormMode mode) {
    return DropdownSearch<ExplotacionAgropecuaria>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'EXPLOTACION AGROPECUARIA',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      dropDownButton: _dropDownButton,
      enabled: mode == FormMode.insert ? true : false,
      mode: Mode.DIALOG,
      showSearchBox: true,
      popupBackgroundColor: Colors.white,
      maxHeight: Get.height * 0.80,
      showAsSuffixIcons: true,
      emptyBuilder: (context, searchEntry) => const Center(child: 
                Text('No encontramos Explotaciones Agropecuarias!', style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
                // controller.mode == FormMode.insert
                //   ? const Text('No encontramos Explotaciones Agropecuarias.\n\nVerifica si seleccionaste la Especie.',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)
                //   : const Text('No encontramos Explotaciones Agropecuarias!', style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)
                // ),
      loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(child: Text('Parece que ha ocurrido un error !',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
      ),
      onFind: (filter) async {
        List<ExplotacionAgropecuaria> listaEA = [];
        // if (controller.mode == FormMode.insert)
        // {
        //   listaEA = await controller.obtenerEACampaniaEspecie(EACampaniaEspecieRequest(
        //       gEconomicoId: controller.paramReqEAResources.gEconomicoId,
        //       empresaId: controller.paramReqEAResources.empresaId,
        //       afipCampaniaId: controller.rxOLAbm.value.campania!.afipCampaniaId!,
        //       especieId: controller.rxOLAbm.value.especie!.especieId!));
        // }
        // else
        // {
          listaEA = await controller.obtenerEACampania(EAResourcesRequest(
              gEconomicoId: controller.paramReqEAResources.gEconomicoId,
              empresaId: controller.paramReqEAResources.empresaId,
              afipCampaniaId: controller.rxOLAbm.value.campania!.afipCampaniaId!));
        //} 
        return listaEA;
      },
      itemAsString: (ExplotacionAgropecuaria? ea) => ea!.clienteNombre!,
      onChanged: (ExplotacionAgropecuaria? ea) async => await controller.setExpAgropecuaria(ea!, true),
      selectedItem: controller.getExpAgropecuaria(),
    );
  }

  //*------------------------------------------------------------------------------------------------------ UA Origen
  Widget _uaOrigen(FormMode mode) {
    return DropdownSearch<UA>(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'UA ORIGEN',
              enabledBorder: _enabledBorder,
              focusedBorder: _focusedBorder,
              labelStyle: _labelStyle,
              disabledBorder: InputBorder.none,
            ),
            dropDownButton: _dropDownButton,
            enabled: mode == FormMode.insert ? true : false,
            popupBackgroundColor: Colors.white,
            maxHeight: Get.height * 0.8,
            mode: Mode.DIALOG,
            showAsSuffixIcons: true,
            itemAsString: (UA? u) => u!.uaNombre!,
            items: controller.recursosEAController.recursosEA.uasOrigen,
            onChanged: (UA? u) => controller.setUaOrigen(u!),
            selectedItem: controller.getUaOrigen(),
          );
  }

  //*------------------------------------------------------------------------------------------------------ UA Destino
  Widget _uaDestino(FormMode mode) {
    return DropdownSearch<UA>(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'UA DESTINO',
              enabledBorder: _enabledBorder,
              focusedBorder: _focusedBorder,
              labelStyle: _labelStyle,
              disabledBorder: InputBorder.none,
            ),
            enabled: mode == FormMode.insert ? true : false,
            dropDownButton: _dropDownButton,
            popupBackgroundColor: Colors.white,
            maxHeight: Get.height * 0.4,
            mode: Mode.DIALOG,
            showAsSuffixIcons: true,
            emptyBuilder: (context, searchEntry) => const Center(child: Text('No encontramos UA de Destino.\n\nVerifica si ya seleccionaste\nuna Explotación Agropecuaria!',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
            loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
            errorBuilder: (context, searchEntry, exception) => const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text('Parece que ha ocurrido un error !',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
            ),
            onFind: (filter) async => 
              await controller.obtenerUADestino(EAUaDestinoRequest(
                    gEconomicoId: controller.paramReqEAResources.gEconomicoId,
                    empresaId: controller.paramReqEAResources.empresaId,
                    tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                    clienteId: controller.getExpAgropecuariaId())),
            itemAsString: (UA? ua) => ua!.uaNombre!,
            onChanged: (UA? ua) => controller.setUaDestino(ua!),
            selectedItem: controller.getUaDestino(),
          );
  }

  //*------------------------------------------------------------------------------------------------------ Fecha Emision
  final textFieldFocusNodeFD = FocusNode();
  Widget _fechaEmi(BuildContext context, String label) {

    final OrdenLaboreoItemPaso1Controller controller = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controller.mode == FormMode.insert) { 
      enabled = true; 
    }
    else if (controller.mode == FormMode.update) { 
      enabled = controller.rxOLAbm.value.estado == "PENDIENTE"; 
    }
    

    return TextFormField(
      enabled: enabled,
      readOnly: true,
      focusNode: textFieldFocusNodeFD,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'EMISION',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.datetime,
      //validator: Utilidades.obligatorio,
      controller: controller.txtFechaEmisionController.value,
      onTap: () async {
        //*-- Deshabilito el foco!
        textFieldFocusNodeFD.unfocus();
        DateTime? _fecha = await selectDate(context, controller.getFecEmi(), label, controller);
        controller.setFecEmi(_fecha ?? controller.getFecEmi());
      },
      onSaved: (value) {
        //controller.apellido = value ?? '';
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Fecha Emision
  final textFieldFocusNodeFV = FocusNode();
  Widget _fechaVto(BuildContext context, String label) {

    //!-- Add Remitar OL
    final OrdenLaboreoItemPaso1Controller controller = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controller.mode == FormMode.insert) { 
      enabled = true; 
    }
    else if (controller.mode == FormMode.update) { 
      enabled = controller.rxOLAbm.value.estado == "PENDIENTE"; 
    }

    return TextFormField(
      enabled: enabled,
      readOnly: true,
      focusNode: textFieldFocusNodeFV,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'VENCIMIENTO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.datetime,
      //validator: Utilidades.obligatorio,
      controller: controller.txtFechaVtoController.value,
      onTap: () async {
        //*-- Deshabilito el foco!
        textFieldFocusNodeFV.unfocus();
        DateTime? _fecha = await selectDate(context, controller.getFecVto(), label, controller);
        controller.setFecVto(_fecha ?? controller.getFecVto());
      },
      onSaved: (value) {
        //controller.apellido = value ?? '';
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Selector de fechas
  Future<DateTime?> selectDate(BuildContext _context, DateTime? _initialDate, String _helpText, OrdenLaboreoItemPaso1Controller _controller) async {


    DateTime _inicial = _controller.mode == FormMode.insert 
                          ? _initialDate ??= DateTime.now()
                          : _initialDate!;

    final DateTime? picked = await showDatePicker(
        context: _context,
        initialDate: _inicial,
        firstDate: _controller.mode == FormMode.insert ? DateTime.now() : _initialDate,
        lastDate: DateTime(DateTime.now().year + 1, 31, 12),
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
}
