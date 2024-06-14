import 'dart:math';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'agenda_cbu_item_provider.dart';


class AgendaCbuItemController extends GetxController with GetSingleTickerProviderStateMixin {

  AgendaCbuItemController();

  final AgendaCbuItemProvider _provider = Get.find<AgendaCbuItemProvider>();
  
  final TextEditingController txtCuitController = TextEditingController();
  final TextEditingController txtAliasController = TextEditingController();
  final TextEditingController txtTitularController = TextEditingController();
  final TextEditingController txtBancoController = TextEditingController();
  final TextEditingController txtTipoDeCuentaController = TextEditingController();
  
  late Solicitud solicitud;
    
  FormMode mode = FormMode.none;
  Rx<bool> saving = false.obs;
  
  List<String> listaTiposDeCuenta = ['OTRAS CUENTAS','CUENTAS PROPIAS'];
  List<String> listaTiposDeCuentaEnBanco = ['CAJA DE AHORRO','CUENTA CORRIENTE'];

  //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<AgendaCbu> rxAgendaCbu = AgendaCbu().obs;

  var agendaId = 0;

  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    agendaId = Get.arguments["id"] as int;
    mode = agendaId == -1 ? FormMode.insert : FormMode.update; 
    super.onInit();
  }

  //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      rxAgendaCbu.value.id = Random().nextInt(10000);
      rxAgendaCbu.value.tipoDeCuenta = listaTiposDeCuenta[0];
      rxAgendaCbu.value.tipoDeCuentaEnBanco = listaTiposDeCuentaEnBanco[0];
    }
    else if (mode == FormMode.update)
    {
      //?--------------------------------------------------------- UPDATE
      try {
        Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
        rxAgendaCbu.value = await _provider.obtenerCbu(agendaId);
        rxAgendaCbu.refresh();
        txtCuitController.text = rxAgendaCbu.value.cuit;
        txtTitularController.text = rxAgendaCbu.value.descripcion;
        txtAliasController.text = rxAgendaCbu.value.cbuAlias;
        txtBancoController.text = rxAgendaCbu.value.banco;
        
        Get.back();
      }
      catch (e)
      {
        Get.back();
      }
    }
    super.onReady();
  }

  //*-------------------------------------------------------------------- Validacion de controles
  String _errorMessage = '';
  bool isValid() {

    _errorMessage = '';

    //* Cuit
    if (rxAgendaCbu.value.cuit == '')  _errorMessage += "Debe especificar el Cuit.\n";
    //* Alias
    if (rxAgendaCbu.value.cbuAlias == '')  _errorMessage += "Debe especificar el Alias o Cbu de la cuenta destino.\n";
    //* Nombre
    if (rxAgendaCbu.value.descripcion == '')  _errorMessage += "Especifique una descripción o referencia de la cuenta.\n";
    //* Banco
    if (rxAgendaCbu.value.banco == '')  _errorMessage += "Especifique el Banco origen de la Cuenta.\n";
    //* Tipo de cuenta
    if (rxAgendaCbu.value.tipoDeCuenta == '')  _errorMessage += "Especifique el Tipo de la Cuenta.\n";
    //* Tipo de cuenta
    if (rxAgendaCbu.value.tipoDeCuentaEnBanco == '')  _errorMessage += "Especifique el Tipo de la Cuenta.\n";
    return _errorMessage.isEmpty;
  }

  //*----------------------------------------------------------------------------------- Guardo/Inserto CBU/Alias
  void save() async {

    try {

      if (!isValid())
      {
        Get.snackbar("ATENCION", _errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error, color: Colors.white),
          backgroundColor: kTRedColor,
          colorText: Colors.white,
          borderRadius: 0.0,
          margin: const EdgeInsets.all(0),
        );
        _errorMessage = '';
      }
      else
      {
        if (mode == FormMode.insert)
        {
          try {
            var result = await _provider.insertarCbu(rxAgendaCbu.value);
            Get.back(result: result);
          }
          catch(e)
          {
            ApiExceptions.procesarError(e);
          }
        }
        else if (mode == FormMode.update)
        {
          var result = await _provider.updateCbu(rxAgendaCbu.value);
          Get.back(result: result);
        }
      }
    } 
    catch(e) {
      saving.toggle();
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }


 
}