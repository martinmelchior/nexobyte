import 'dart:math';

import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:intl/intl.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'efectivo_item_provider.dart';


class EfectivoItemController extends GetxController with GetSingleTickerProviderStateMixin {

  EfectivoItemController();

  final EfectivoItemProvider _provider = Get.find<EfectivoItemProvider>();
  
  final TextEditingController txtFechaEntregaController = TextEditingController();
  final TextEditingController txtEfectivoController = TextEditingController();
  
  late Solicitud solicitud;
    
  FormMode mode = FormMode.none;
  Rx<bool> saving = false.obs;
  Rx<String> letras = ''.obs;

  //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<SOEfectivo> rxEfectivo = SOEfectivo().obs;


  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pEfectivoId = Get.arguments["efectivoId"] as int;
    mode = pEfectivoId == -1 ? FormMode.insert : FormMode.update; 
    super.onInit();
  }

  //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      rxEfectivo.value.efectivoId = Random().nextInt(10000);
      rxEfectivo.value.estado = "PENDIENTE";
      setFecEntrega(DateTime.now());
    }
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- fecha de Labor
  DateTime getFecEntrega() { return rxEfectivo.value.fechaEntrega!; }
  setFecEntrega(DateTime _fe) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    txtFechaEntregaController.text = formatter.format(_fe).toString();
    rxEfectivo.value.fechaEntrega = _fe;
  }

  //*-------------------------------------------------------------------- Validacion de controles
  String _errorMessage = '';
  bool isValid() {

    _errorMessage = '';

    //* Fecha de Entrega
    if (rxEfectivo.value.fechaEntrega == null)  _errorMessage += "Falta la Fecha de Entrega.\n";
    //* Importe
    if (rxEfectivo.value.importe == null || rxEfectivo.value.importe! == 0.0) _errorMessage += "Debe ingresar el monto que necesita.\n";

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
          Get.back(result: rxEfectivo.value);
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

}