import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/adelantos_model.dart';
import 'transferencia_item_controller.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class TransferenciaItemPage extends GetView<TransferenciaItemController> {
  
  final GlobalKey<FormState> _key = GlobalKey();

  TransferenciaItemPage({Key? key}) : super(key: key);

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  List<Bubble> listaBuble = [];

  @override
  Widget build(BuildContext context) {
    
    String titulo = controller.mode == FormMode.insert ? 'Solicitar Transferencia' : 'Modificar Transferencia';

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
              title: Column(
                children: [
                  Text(titulo, style: const TextStyle(fontSize: 16.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
                  Text(controller.getSubTitulo(), style: const TextStyle(fontSize: 14.0, fontFamily: 'Sora', color: Colors.orange)),
                ],
              ),
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
                        _cuentaDestinoTransferencia(),
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text('Las cuentas mostradas aquí son las de su Agenda CBU.', style: TextStyle(color: kTRedColor, fontSize: 12.0)),
                        ),
                        const SizedBox(height: 30.0),
                        _fechaDeTransferencia(context, "Fecha de Transferencia"),
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

  //*------------------------------------------------------------------------------------------------------ Fecha de Transferencia
  final textFieldFocusNodeFT = FocusNode();
  Widget _fechaDeTransferencia(BuildContext context, String label) {

    DateTime last = DateTime.now().add(const Duration(days: 90));

    return TextFormField(
      readOnly: true,
      focusNode: textFieldFocusNodeFT,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        suffixIconColor: Colors.black54,
        labelText: 'FECHA DE TRANSFERENCIA',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.datetime,
      validator: Utilidades.obligatorio,
      controller: controller.txtFechaTransferenciaController,
      onTap: () async {
        //*-- Deshabilito el foco!
        textFieldFocusNodeFT.unfocus();
        DateTime? _fecha = await MyDateUtils.selectDate(context, controller.getFecTransferencia(), DateTime.now(), last, label);
        controller.setFecTransferencia(_fecha ?? controller.getFecTransferencia());
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
        labelText: 'MONTO',
        labelStyle: _labelStyle,
        hintText: "Monto ...",
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
        controller.rxTransferencia.value.importe = c;
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ _cuentaDestinoTrasnferencia
  Widget _cuentaDestinoTransferencia() {

    return DropdownSearch<AgendaCbu>(
      dropdownSearchDecoration: InputDecoration(
          labelText: 'CUENTA CBU / ALIAS DESTINO',
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelStyle: _labelStyle,
          disabledBorder: InputBorder.none,
        ),
      enabled: controller.mode == FormMode.insert ? true : false,
      mode: Mode.BOTTOM_SHEET,
      popupTitle: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () async => await Get.toNamed(AppRoutes.rAgendaCbuLista, arguments: { 'tipoDeCuenta': controller.tipoDeCuenta.toValueText }),
              child: const Text('Agregar CBU / Alias')),
          ),
        ],
      ),
      emptyBuilder: (context, searchEntry) => const Center(child: Text('No encontramos Cuentas en tu Agenda CBU!\nAvisa a los Administradores.', style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
      loadingBuilder: (context, searchEntry) => const Center(child: Column(
        children: [
          SizedBox(height: 20),
          Text('Aguarde un momento ...'),
          SizedBox(height: 20),
          kTCpi,
        ],
      )),
      errorBuilder: (context, searchEntry, exception) => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(child: Text('Parece que ha ocurrido un error !',style: TextStyle(fontSize: 14, color: Colors.black54), textAlign: TextAlign.center)),
      ),
      maxHeight: Get.height * 0.50,
      popupItemBuilder: (context, item, isSelected) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.descripcion.toUpperCase(), style: const TextStyle(fontSize: 13.0, color: Colors.red)),
                Text(item.cbuAlias.toUpperCase(),  style: const TextStyle(fontSize: 13.0)),
                const Text('CBU/ALIAS',  style: TextStyle(fontSize: 10.0, color: Colors.black38)),
                const SizedBox(height: 4.0),
                Text(item.cuit, style: const TextStyle(fontSize: 13.0)),
                const Text('CUIT',  style: TextStyle(fontSize: 10.0, color: Colors.black38)),
                const SizedBox(height: 4.0),
                Text(item.tipoDeCuenta,  style: const TextStyle(fontSize: 13.0)),
                const SizedBox(height: 5.0),
                Text(item.banco,  style: const TextStyle(fontSize: 13.0)),
                Text(item.tipoDeCuentaEnBanco,  style: const TextStyle(fontSize: 13.0)),
                const Divider(color: Colors.black),
              ]
          ),
        );
      },
      popupBackgroundColor: Colors.white,
      onFind: (filter) async {
        List<AgendaCbu> listaDeCuentasDestino = [];
        listaDeCuentasDestino = await controller.obtenerAgendaCbu(controller.tipoDeCuenta);
        return listaDeCuentasDestino;
      },
      onChanged: (AgendaCbu? cbu) async => controller.setAgendaCbu(cbu!, false),
    );

  }
}
