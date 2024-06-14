
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'efectivo_item_controller.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


class EfectivoItemPage extends GetView<EfectivoItemController> {
  
  final GlobalKey<FormState> _key = GlobalKey();

  EfectivoItemPage({Key? key}) : super(key: key);

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  List<Bubble> listaBuble = [];

  @override
  Widget build(BuildContext context) {
    
    String titulo = controller.mode == FormMode.insert ? 'Solicitar Efectivo' : 'Modificar Efectivo';

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
                        _fechaEntrega(context, "Fecha"),
                        const SizedBox(height: 30.0),
                        _efectivo(),
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
  Widget _fechaEntrega(BuildContext context, String label) {

    DateTime last = DateTime.now().add(const Duration(days: 90));

    return TextFormField(
      readOnly: true,
      focusNode: textFieldFocusNodeFE,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'FECHA DE ENTREGA',
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
        DateTime? _fecha = await MyDateUtils.selectDate(context, controller.getFecEntrega(), DateTime.now(), last, label);
        controller.setFecEntrega(_fecha ?? controller.getFecEntrega());
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Efectvo
  Widget _efectivo() {
    
    return TextFormField(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'MONTO NECESARIO',
        labelStyle: _labelStyle,
        hintText: "Monto necesario ...",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(13), //max length
        CurrencyInputFormatter(
            useSymbolPadding: true,
            mantissaLength: 2 // the length of the fractional side
        )
      ],
      controller: controller.txtEfectivoController,
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
        controller.rxEfectivo.value.importe = c;
      },
    );
  }

}
