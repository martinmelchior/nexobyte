import 'dart:math';

import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:intl/intl.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cta_cte_resumen_saldo.dart';
import 'cheque_item_provider.dart';


class ChequeItemController extends GetxController with GetSingleTickerProviderStateMixin {

  ChequeItemController();

  final ChequeItemProvider _provider = Get.find<ChequeItemProvider>();
  
  SOBanco bcoSinSeleccion = SOBanco(banId: -1, nombre: '', defaultInApp: false);

  final TextEditingController txtFechaEntregaController = TextEditingController();
  final TextEditingController txtChequeController = TextEditingController();
  final TextEditingController txtANombreDeController = TextEditingController();
  
  late Solicitud solicitud;
    
  FormMode mode = FormMode.none;
  Rx<bool> saving = false.obs;
  Rx<String> letras = ''.obs;

  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  late ObtenerBancosResponse responseBancos;

  //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<SOCheque> rxCheque = SOCheque().obs;


  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pChequeId = Get.arguments["chequeId"] as int;
    itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;
    mode = pChequeId == -1 ? FormMode.insert : FormMode.update; 
    super.onInit();
  }

  //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      rxCheque.value.chequeId = Random().nextInt(10000);
      rxCheque.value.estado = "PENDIENTE";
      setFecVto(DateTime.now());

      responseBancos = await _provider.obtenerBancos(itemResumenCtaCte);
      for (SOBanco b in responseBancos.listaDeBancos) {
        if (b.defaultInApp)
        {
          setBanco(SOBanco(banId: b.banId, nombre: b.nombre, defaultInApp: b.defaultInApp), false);
        }
      }
    }
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- fechaVto
  DateTime getFecVto() { return rxCheque.value.fechaVto!; }
  setFecVto(DateTime _fv) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    txtFechaEntregaController.text = formatter.format(_fv).toString();
    rxCheque.value.fechaVto = _fv;
  }

  //*-------------------------------------------------------------------- Validacion de controles
  String _errorMessage = '';
  bool isValid() {

    _errorMessage = '';

    //* Fecha de Entrega
    if (rxCheque.value.fechaVto == null)  _errorMessage += "Falta la Fecha de Vto.\n";
    //* Banco
    if (rxCheque.value.banco == null)  _errorMessage += "Seleccione un Banco.\n";
    //* Importe
    if (rxCheque.value.importe == null || rxCheque.value.importe! == 0.0) _errorMessage += "Debe ingresar el monto del Cheque.\n";

    return _errorMessage.isEmpty;
  }

  //*----------------------------------------------------------------------------------- Guardo Cheque
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
          Get.back(result: rxCheque.value);
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
  Future<List<SOBanco>> obtenerBancos() async {
    List<SOBanco> listaResult = [];
    try {
      ObtenerBancosResponse response = await _provider.obtenerBancos(itemResumenCtaCte);
      return response.listaDeBancos;
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaResult;
  }

  //*----------------------------------------------------------------------------------- bancos
  int getBancoId() { 
    int returnValue = 0;
    if (rxCheque.value.banId != null) { returnValue = rxCheque.value.banId!; }
    return returnValue;
  }
  SOBanco getBanco() { 
    SOBanco returnValue = bcoSinSeleccion;
    if (rxCheque.value.banId != null) 
    { 
      returnValue = SOBanco(
        banId: rxCheque.value.banId!,  
        nombre: rxCheque.value.banco!,
      ); 
    }
    return returnValue;
  }
  void setBanco(SOBanco bb, bool refreshCombos) { 
    if (rxCheque.value.banId == null || bb.banId != rxCheque.value.banId)
    {
      rxCheque.value.banId = bb.banId;  
      rxCheque.value.banco = bb.nombre;
      rxCheque.refresh();
    } 
  }

}