
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/adelantos_model.dart';
import 'cheque_item_controller.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class ChequeItemPage extends GetView<ChequeItemController> {
  
  final GlobalKey<FormState> _key = GlobalKey();

  ChequeItemPage({Key? key}) : super(key: key);

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  List<Bubble> listaBuble = [];

  @override
  Widget build(BuildContext context) {
    
    String titulo = controller.mode == FormMode.insert ? 'Solicitar Cheque' : 'Modificar Cheque';

    return  Form(
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
              title: Text(titulo, style: const TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
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
                        _fechaVto(context, "Fecha"),
                        const SizedBox(height: 30.0),
                        Obx(() => _bancos()),
                        const SizedBox(height: 20.0),
                        _aNombreDe(),
                        const SizedBox(height: 20.0),
                        _montoCheque(),
                        const SizedBox(height: 20.0),
                        Obx((() => Text(controller.letras.value.toLowerCase(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.indigo, fontSize: 14, fontStyle: FontStyle.italic)))),
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
                              child: const Text('Guardar',
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
                ),
                
              ],
            ),
          ),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Fecha de Entrega
  final textFieldFocusNodeFE = FocusNode();
  Widget _fechaVto(BuildContext context, String label) {

    DateTime last = DateTime.now().add(const Duration(days: 90));

    return TextFormField(
      readOnly: true,
      focusNode: textFieldFocusNodeFE,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'FECHA DE VTO',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.datetime,
      validator: Utilidades.obligatorio,
      controller: controller.txtFechaEntregaController,
      onTap: () async {
        //*-- Deshabilito el foco!
        textFieldFocusNodeFE.unfocus();
        DateTime? _fecha = await MyDateUtils.selectDate(context, controller.getFecVto(), DateTime.now(), last, label);
        controller.setFecVto(_fecha ?? controller.getFecVto());
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Importe del Cheque
  Widget _montoCheque() {
    
    return TextFormField(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'IMPORTE DEL CHEQUE',
        labelStyle: _labelStyle,
        hintText: "Importe del cheque ...",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(13), //max length
        CurrencyInputFormatter(
            useSymbolPadding: true,
            mantissaLength: 2 // the length of the fractional side
        )
      ],
      controller: controller.txtChequeController,
      onChanged: (value) {
        value = value.replaceAll(',', ''); //*-- para que siga funcionando la funcion
        controller.letras.value = Utils.convertirImporteALetras2( double.parse(value) );
      },
      onSaved: (value) {
        double c = 0.0;
        if (value!.isNotEmpty) {
          value = value.replaceAll(',', ''); //*-- para que siga funcionando la funcion
          c = double.parse(value);
        }
        controller.rxCheque.value.importe = c;
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Bancos
  Widget _bancos() {

    return DropdownSearch<SOBanco>(
      dropdownSearchDecoration: InputDecoration(
          labelText: 'BANCO',
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelStyle: _labelStyle,
          disabledBorder: InputBorder.none,
          enabled: controller.mode == FormMode.insert ? true : false,
        ),
      mode: Mode.MENU,
      emptyBuilder: (context, searchEntry) => const Center(child: Text('No encontramos Bancos!\nAvisa a los Administradores.', style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
        loadingBuilder: (context, searchEntry) => const Center(child: kTCpi),
        errorBuilder: (context, searchEntry, exception) => const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text('Parece que ha ocurrido un error !',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
        ),
      maxHeight: Get.height * 0.50,
      onFind: (filter) async {
        List<SOBanco> listaDeBancos = [];
        listaDeBancos = await controller.obtenerBancos();
        return listaDeBancos;
      },
      popupBackgroundColor: Colors.white,
      itemAsString: (SOBanco? bb) => bb!.nombre,
      onChanged: (SOBanco? bb) async => controller.setBanco(bb!, true),
      selectedItem: controller.getBanco(),
    );

  }


  //*------------------------------------------------------------------------------------------------------ A nombre de
  Widget _aNombreDe() {
    return TextFormField(
      maxLength: 100,
      style: const TextStyle(
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'LIBRAR A FAVOR DE',
        labelStyle: _labelStyle,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        hintText: 'Dejar en blanco si no especifica',
      ),
      keyboardType: TextInputType.text,
      controller: controller.txtANombreDeController,
      onSaved: (value) {
        controller.rxCheque.value.aNombreDe = value;
      },
    );
  }

}
