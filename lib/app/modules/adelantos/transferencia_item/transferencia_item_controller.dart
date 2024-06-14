import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../data/models/cta_cte_resumen_saldo.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/manager_api_exceptions.dart';
import '../model/adelantos_model.dart';
import 'transferencia_item_provider.dart';


class TransferenciaItemController extends GetxController with GetSingleTickerProviderStateMixin {

  TransferenciaItemController();

  final TransferenciaItemProvider _provider = Get.find<TransferenciaItemProvider>();
  
  final TextEditingController txtFechaTransferenciaController = TextEditingController();
  final TextEditingController txtEfectivoController = TextEditingController();
  
  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  late Solicitud solicitud;
  TipoDeCuenta tipoDeCuenta = TipoDeCuenta.todas;
  
  FormMode mode = FormMode.none;
  Rx<bool> saving = false.obs;
  Rx<String> letras = ''.obs;

  //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<SOTransferencia> rxTransferencia = SOTransferencia().obs;


  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pTransferenciaId = Get.arguments["transferenciaId"] as int;
    itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;
    tipoDeCuenta =  TipoDeCuenta.values.byName(Get.arguments["tipoDeCuenta"]);
    mode = pTransferenciaId == -1 ? FormMode.insert : FormMode.update; 
    super.onInit();
  }

  String getSubTitulo() {
    String titulo = "TODAS LAS CUENTAS";
    if (tipoDeCuenta == TipoDeCuenta.cuentaspropias) { titulo = "CUENTAS PROPIAS"; }
    else if (tipoDeCuenta == TipoDeCuenta.otrascuentas) { titulo = "OTRAS CUENTAS"; }
    return titulo;
  }
  
  //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      rxTransferencia.value.transferenciaId = Random().nextInt(10000);
      rxTransferencia.value.estado = "PENDIENTE";
      setFecTransferencia(DateTime.now());
    }
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- fecha de Labor
  DateTime getFecTransferencia() { return rxTransferencia.value.fechaTransferencia!; }
  setFecTransferencia(DateTime _fe) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    txtFechaTransferenciaController.text = formatter.format(_fe).toString();
    rxTransferencia.value.fechaTransferencia = _fe;
  }

  //*-------------------------------------------------------------------- Validacion de controles
  String _errorMessage = '';
  bool isValid() {

    _errorMessage = '';

    //* cuentas
    if (rxTransferencia.value.banco == null ||rxTransferencia.value.cbuAlias == null ||rxTransferencia.value.descripcion == null ||rxTransferencia.value.tipoDeCuenta == null) _errorMessage += "Seleccione la cuenta destino.\n";
    //* Fecha 
    if (rxTransferencia.value.fechaTransferencia == null)  _errorMessage += "Falta la Fecha de Transferencia.\n";
    //* Importe
    if (rxTransferencia.value.importe == null || rxTransferencia.value.importe! == 0.0) _errorMessage += "Debe ingresar el monto.\n";

    return _errorMessage.isEmpty;
  }

  //*----------------------------------------------------------------------------------- Guardo Efectivo
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
          Get.back(result: rxTransferencia.value);
        }
        else if (mode == FormMode.update)
        {
          //await _provider.updateOL(paso1Controller.rxOLAbm.value);
        }
      }
    } 
    catch(e) {
      saving.toggle();
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }


  //*----------------------------------------------------------------------------------- obtenerCtasCtesOrigen
  Future<List<AgendaCbu>> obtenerAgendaCbu(tipoDeCuenta) async {
    List<AgendaCbu> listaResult = [];
    try {
      AgendaCbuResponse response = await _provider.obtenerAgendaCbu(tipoDeCuenta);
      listaResult = response.listaDeCbuAlias;
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaResult;
  }

  //*----------------------------------------------------------------------------------- tipo de cuenta
  // int getTransfBancoId() { 
  //   int returnValue = 0;
  //   if (rxCheque.value.banId != null) { returnValue = rxCheque.value.banId!; }
  //   return returnValue;
  // }
  // SOBanco getBanco() { 
  //   SOBanco returnValue = bcoSinSeleccion;
  //   if (rxCheque.value.banId != null) 
  //   { 
  //     returnValue = SOBanco(
  //       banId: rxCheque.value.banId!,  
  //       nombre: rxCheque.value.banco!,
  //     ); 
  //   }
  //   return returnValue;
  // }
  void setAgendaCbu(AgendaCbu cbu, bool refreshCombos) { 
    rxTransferencia.value.estado = "PENDIENTE";  
    rxTransferencia.value.banco = cbu.banco;
    rxTransferencia.value.cbuAlias = cbu.cbuAlias;
    rxTransferencia.value.descripcion = cbu.descripcion;
    rxTransferencia.value.cuit = cbu.cuit;
    rxTransferencia.value.tipoDeCuenta = tipoDeCuenta.toValueSqlFilter;
  }



}