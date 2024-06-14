import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/lluvias/model/lluvias_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';

import 'lluvias_item_provider.dart';

class LluviasItemController extends GetxController {

  LluviasItemController();

  //final MenuIngenierosController recursosEAController = Get.find<MenuIngenierosController>();
  final LluviasItemProvider _provider = Get.find<LluviasItemProvider>();
  
  final TextEditingController txtFechaController    = TextEditingController();
  final TextEditingController txtCantidadController = TextEditingController();
  
  late OrdenesLaboreosResumenDeIngenieroItem resumenDeIngenieroItem;
  late EAResourcesResponse recursosEA;
  FormMode mode = FormMode.none;
  Rx<bool> saving = false.obs;

  // //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<Lluvia> rxLluviaItem = Lluvia().obs;

  ExplotacionAgropecuaria eaSinSeleccion = ExplotacionAgropecuaria(clienteId: -1, clienteNombre: '');

  // //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pLluviaId = Get.arguments["lluviaId"] as int;
    mode = pLluviaId == -1 ? FormMode.insert : FormMode.update; 
    resumenDeIngenieroItem = Get.arguments["resumenDeIngenieroItem"] as OrdenesLaboreosResumenDeIngenieroItem;
    recursosEA = Get.arguments["recursosEA"] as EAResourcesResponse;

    if (recursosEA.campanias.isNotEmpty)
    {
      //?-- Aca tengo las 2 campañas que tengo que mostrar desde los resources!
      setCampania(recursosEA.campanias[0], false);   
    }
    else
    {
      //?-- Si no hay campañas genero una para que no sea null
      setCampania(Campania(afipCampaniaId: 999, codigo: '999', descripcion: 'SELECCIONE UNA CAMPAÑA'), false);
    }

    super.onInit();
  }

  // //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      //-- Seteo de campos defaults
      setFecha = DateTime.now();
    }
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- Filtrar las EA por CAMPAÑA/ESPECIE
  Future<List<ExplotacionAgropecuaria>> obtenerEACampania(EACampaniaRequest req) async {
    List<ExplotacionAgropecuaria> listaEA = [];
    try {
      EACampaniaResponse result = await _provider.obtenerEACampania(
                                                            EACampaniaRequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                            ));

      listaEA = result.eas;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaEA;
  }

  //*----------------------------------------------------------------------------------- Guardar Movimiento Interno
  Future<SaveLluviaResponse> guardarLluvia() async {
    SaveLluviaResponse result = SaveLluviaResponse();
    try {
      SaveLluviaRequest req = SaveLluviaRequest(
        gEconomicoId:     resumenDeIngenieroItem.gEconomicoId,
        empresaId:        resumenDeIngenieroItem.empresaId,
        tokenDeRefresco:  PreferenciasDeUsuarioStorage.tokenDeRefresco,
        lluvia:           rxLluviaItem.value,
        ingenieroId:      -1,
        contratistaId:    -1,
      );
  
      result = await _provider.guardarLluvia(req);
    } 
    catch (e) {
      rethrow;
    }
    return result;
  }
  
  String _errorMessage = '';

  // //*-------------------------------------------------------------------- Validacion de controles
  bool pageIsValid() {

    //-- Limpio Errores
    _errorMessage = '';
    
    //*-------------------------------------------------------------------- Fecha de descarga
    if (rxLluviaItem.value.fecha == null)
    {
      _errorMessage += "Seleccione la fecha de la lluvia.\n";
    }
    //*-------------------------------------------------------------------- Campaña
    if (rxLluviaItem.value.campania == null ||
        rxLluviaItem.value.campania!.afipCampaniaId == null ||
        rxLluviaItem.value.campania!.afipCampaniaId == -1)
    {
      _errorMessage += "Seleccione una Campaña.\n";
    }
    //*-------------------------------------------------------------------- Exp Agropecuaria
    if (rxLluviaItem.value.ea == null ||
        rxLluviaItem.value.ea!.clienteId == null ||
        rxLluviaItem.value.ea!.clienteId == -1)
    {
      _errorMessage += "Seleccione una Exp.Agropecuaria.\n";
    }
    //*-------------------------------------------------------------------- Cantidad
    if (rxLluviaItem.value.precipitacion == null ||
        rxLluviaItem.value.precipitacion! <= 0)
    {
      _errorMessage += "Ingrese la cantidad de milímetros caídos.\n";
    }

    return _errorMessage.isEmpty;
  }
  
  // //*----------------------------------------------------------------------------------- Filtrar UAs
   void save() async {

    try {

      if (!pageIsValid())
      {
        Get.snackbar("ATENCION", _errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error, color: Colors.white),
          backgroundColor: kTRedColor,
          colorText: Colors.white,
          borderRadius: 0.0,
          margin: const EdgeInsets.all(0),
        );
      }
      else
      {
        Get.dialog(const Center(child: kTCpi));
        saving.toggle();
        await guardarLluvia();
        saving.toggle();
        Get.back();

        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Listo'),
            titleTextStyle: const TextStyle(fontSize: 18, color: kTAllLabelsColor),
            content: const Text('El registro de lluvia fue guardado correctamente !'),
            contentTextStyle: const TextStyle(fontSize: 16, color: kTAllLabelsColor),
            actions: [
              TextButton(
                style: kTButtonStyle,
                child: const Text("Cerrar"),
                //onPressed: () => Get.until((route) => Get.currentRoute == AppRoutes.rMovInternoList),
                onPressed: () { 
                  if (Get.isDialogOpen!) 
                  {
                    Get.back();
                  }
                  Get.back(result: true);}
              )
            ]
          ),
          barrierDismissible: false,
        );
      }

      _errorMessage = '';
    } 
    catch(e) {
      saving.toggle();
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }
  
  
  // //*----------------------------------------------------------------------------------- Campania Seleccionada
  int getCampaniaId() { 
    int returnValue = 0;
    if (rxLluviaItem.value.campania != null) { returnValue = rxLluviaItem.value.campania!.afipCampaniaId!; }
    return returnValue;
  }
  Campania getCampania() { 
    Campania returnValue = Campania();
    if (rxLluviaItem.value.campania != null) { returnValue = rxLluviaItem.value.campania!; }
    return returnValue;
  }
  void setCampania(Campania c, bool refreshCombos) async {
    if ((rxLluviaItem.value.campania == null) || 
        (rxLluviaItem.value.campania != null && c.afipCampaniaId != rxLluviaItem.value.campania!.afipCampaniaId))
    {
      //?-- Seteo solo si se cambio la campaña
      rxLluviaItem.value.campania = c; 
      if (refreshCombos)
      {
        rxLluviaItem.value.ea = eaSinSeleccion;
      }
      rxLluviaItem.refresh();
    }
  }

  //*----------------------------------------------------------------------------------- Explotacion Agropecuaria
  int getExpAgropecuariaId() { 
    int returnValue = 0;
    if (rxLluviaItem.value.ea != null) { returnValue = rxLluviaItem.value.ea!.clienteId!; }
    return returnValue;
  }
  ExplotacionAgropecuaria getExpAgropecuaria() { 
    ExplotacionAgropecuaria returnValue = eaSinSeleccion;
    if (rxLluviaItem.value.ea != null) { returnValue = rxLluviaItem.value.ea!; }
    return returnValue;
  }
  void setExpAgropecuaria(ExplotacionAgropecuaria ea, bool refreshCombos) { 
    if ((rxLluviaItem.value.ea == null) || 
        (rxLluviaItem.value.ea != null && ea.clienteId != rxLluviaItem.value.ea!.clienteId))
    {
      rxLluviaItem.value.ea = ea; 
      rxLluviaItem.refresh();
    } //-- Piso para pedir los lotes que tengan esta especie
  }


  // //*----------------------------------------------------------------------------------- Kilos
  int getCantidad() { 
    int returnValue = 0;
    if (rxLluviaItem.value.precipitacion != null) { returnValue = rxLluviaItem.value.precipitacion!; }
    return returnValue;
  }
  void setCantidad(String c) { 
    if ((rxLluviaItem.value.precipitacion == null) || 
        (rxLluviaItem.value.precipitacion != null && double.parse(c)!= rxLluviaItem.value.precipitacion))
    {
      txtCantidadController.text = c;
      rxLluviaItem.value.precipitacion = int.parse(c); 
      rxLluviaItem.refresh();
    } 
  }

  // //*----------------------------------------------------------------------------------- fecha de descarga
  DateTime get getFecha { return rxLluviaItem.value.fecha!; }
  set setFecha(DateTime _fd) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    txtFechaController.text = formatter.format(_fd).toString();
    rxLluviaItem.value.fecha = _fd;
  }
}