
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'agenda_cbu_item_controller.dart';

class AgendaCbuItemPage extends GetView<AgendaCbuItemController> {
  
  final GlobalKey<FormState> _key = GlobalKey();

  AgendaCbuItemPage({Key? key}) : super(key: key);

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final Widget _dropDownButton = const Icon(Icons.arrow_drop_down, size: 40);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  List<Bubble> listaBuble = [];

  @override
  Widget build(BuildContext context) {
    
    String titulo = controller.mode == FormMode.insert ? 'Nuevo  CBU / Alias' : 'Modificar  CBU / Alias';

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
                        _cuit(),
                        const SizedBox(height: 30.0),
                        _titular(),
                        const SizedBox(height: 30.0),
                        _aliascbu(),
                        const SizedBox(height: 30.0),
                        Obx(() => _tipoDeCuenta()),
                        const SizedBox(height: 30.0),
                        _banco(),
                        const SizedBox(height: 30.0),
                        Obx(() =>_tipoDeCuentaEnBanco()),
                        const SizedBox(height: 30.0),
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
                              child: const Text('Guardar CBU / Alias',
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

  //*------------------------------------------------------------------------------------------------------ cuit
  Widget _cuit() {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Cuit Destino',
        labelStyle: _labelStyle,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(13), //max length
      ],
      controller: controller.txtCuitController,
      onSaved: (value) {
        controller.rxAgendaCbu.value.cuit = value.toString();
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ _aliascbu
  Widget _aliascbu() {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Alias o CBU',
        labelStyle: _labelStyle,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      keyboardType: TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(22), //max length
      ],
      controller: controller.txtAliasController,
      onSaved: (value) {
        controller.rxAgendaCbu.value.cbuAlias = value.toString();
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ cuit
  Widget _titular() {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Titular',
        labelStyle: _labelStyle,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      keyboardType: TextInputType.text,
      controller: controller.txtTitularController,
      onSaved: (value) {
        controller.rxAgendaCbu.value.descripcion = value.toString();
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ tipo de cuenta
  Widget _tipoDeCuenta() {

    return DropdownSearch<String>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Tipo de Cuenta',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),
      enabled: controller.mode == FormMode.insert ? true : false,
      maxHeight: Get.height * 0.20,
      mode: Mode.MENU,
      popupBackgroundColor: Colors.white,
      items: controller.listaTiposDeCuenta,
      selectedItem: controller.rxAgendaCbu.value.tipoDeCuenta,
      onChanged: (value) => controller.rxAgendaCbu.value.tipoDeCuenta = value.toString(),
      onSaved: (value) => controller.rxAgendaCbu.value.tipoDeCuenta = value.toString(),
    );

  }

  //*------------------------------------------------------------------------------------------------------ tipo de cuenta en banco
  Widget _tipoDeCuentaEnBanco() {

    return DropdownSearch<String>(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Tipo de Cuenta en Banco',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        disabledBorder: InputBorder.none,
      ),      
      maxHeight: Get.height * 0.20,
      mode: Mode.MENU,
      popupBackgroundColor: Colors.white,
      items: controller.listaTiposDeCuentaEnBanco,
      selectedItem: controller.rxAgendaCbu.value.tipoDeCuentaEnBanco,
      onChanged: (value) => controller.rxAgendaCbu.value.tipoDeCuentaEnBanco = value.toString(),
      onSaved: (value) => controller.rxAgendaCbu.value.tipoDeCuentaEnBanco = value.toString(),
    );

  }


  //*------------------------------------------------------------------------------------------------------ banco
  Widget _banco() {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black54,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelText: 'Banco de la cuenta',
        labelStyle: _labelStyle,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      keyboardType: TextInputType.text,
      controller: controller.txtBancoController,
      onSaved: (value) {
        controller.rxAgendaCbu.value.banco = value.toString();
      },
    );
  }
}
