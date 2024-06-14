import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';

import 'mov_interno_provider.dart';

class MovInternoItemController extends GetxController {

  MovInternoItemController();

  //final MenuIngenierosController recursosEAController = Get.find<MenuIngenierosController>();
  final MovInternoItemProvider _provider = Get.find<MovInternoItemProvider>();
  
  final TextEditingController txtFechaDescargaController    = TextEditingController();
  final TextEditingController txtCantidadController         = TextEditingController();
  
  EAResourcesRequest paramReqEAResources = EAResourcesRequest();
  EAResourcesResponse eaResources = EAResourcesResponse();
  FormMode mode = FormMode.none;
  Rx<bool> saving = false.obs;

  //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<MovimientoInterno> rxMovimientoInternoItem = MovimientoInterno().obs;

  Especie especieSinSeleccion = Especie(especieId: -1, nombre: '');
  ExplotacionAgropecuaria eaSinSeleccion = ExplotacionAgropecuaria(clienteId: -1, clienteNombre: '');
  Lote loteSinSeleccion = Lote(loteId: -1, loteNombre: '', cantHas: 0);
  UA uaSinSeleccion = UA(uaId: -1, uaNombre: '');

  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pMovId = Get.arguments["movId"] as int;
    paramReqEAResources = Get.arguments["requestEARerources"] as EAResourcesRequest;
    eaResources = Get.arguments["eaResources"] as EAResourcesResponse;
    mode = pMovId == -1 ? FormMode.insert : FormMode.update; 

    if (eaResources.campanias.isNotEmpty)
    {
      //?-- Aca tengo las 2 campañas que tengo que mostrar desde los resources!
      setCampania(eaResources.campanias[0], false);   
    }
    else
    {
      //?-- Si no hay campañas genero una para que no sea null
      setCampania(Campania(afipCampaniaId: 999, codigo: '999', descripcion: 'SELECCIONE UNA CAMPAÑA'), false);
    }

    super.onInit();
  }

  //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      //-- Seteo de campos defaults
      movFechaDeDescarga = DateTime.now();

      
    }
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- Filtrar ESPECIE
  Future<List<Especie>> obtenerEspeciesEnCampania(EAEspecieEnCampaniaRequest req) async {
    List<Especie> especies = [];
    try {
      EAEspecieEnCampaniaResponse result = await _provider.obtenerEspeciesEnCampania(
                                                            EAEspecieEnCampaniaRequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                            ));
      especies = result.especies;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return especies;
  }

  //*----------------------------------------------------------------------------------- Filtrar las EA por CAMPAÑA/ESPECIE
  Future<List<ExplotacionAgropecuaria>> obtenerEACampaniaEspecie(EACampaniaEspecieRequest req) async {
    List<ExplotacionAgropecuaria> listaEA = [];
    try {
      EACampaniaEspecieResponse result = await _provider.obtenerEACampaniaEspecie(
                                                            EACampaniaEspecieRequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                              especieId:      req.especieId,
                                                            ));

      listaEA = result.eas;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaEA;
  }

  //*----------------------------------------------------------------------------------- Filtrar LOTES
  Future<List<Lote>> obtenerLotesPorCampaniaEspecieEA(LotesPorCampaniaEspecieEARequest req) async {
    List<Lote> listaLotes = [];
    try {
      LotesPorCampaniaEspecieEAResponse result = await _provider.obtenerLotesPorCampaniaEspecieEA(
                                                            LotesPorCampaniaEspecieEARequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              clienteId:      req.clienteId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                              especieId:      req.especieId,
                                                            ));

      listaLotes = result.lotes;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaLotes;
  }

  //*----------------------------------------------------------------------------------- Filtrar UAs
  Future<List<UA>> obtenerUAsPorCampaniaEspecieEA(UAsPorCampaniaEspecieEARequest req) async {
    List<UA> listaUAs = [];
    try {
      UAsPorCampaniaEspecieEAResponse result = await _provider.obtenerUAsPorCampaniaEspecieEA(
                                                            UAsPorCampaniaEspecieEARequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              clienteId:      req.clienteId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                              especieId:      req.especieId,
                                                            ));

      listaUAs = result.uas;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaUAs;
  }
  
  //*----------------------------------------------------------------------------------- Guardar Movimiento Interno
  Future<MovimientoResponse> guardarMovimientoInterno() async {
    MovimientoResponse result = MovimientoResponse();
    try {
      MovimientoRequest req = MovimientoRequest(
        gEconomicoId: paramReqEAResources.gEconomicoId,
        empresaId: paramReqEAResources.empresaId,
        movInterno: rxMovimientoInternoItem.value,
      );
      result = await _provider.guardarMovimientoInterno(req);
    } 
    catch (e) {
      rethrow;
    }
    return result;
  }
  
  String _errorMessage = '';

  //*-------------------------------------------------------------------- Validacion de controles
  bool pageIsValid() {

    //-- Limpio Errores
    _errorMessage = '';
    
    //*-------------------------------------------------------------------- Fecha de descarga
    if (rxMovimientoInternoItem.value.fechaDescarga == null)
    {
      _errorMessage += "Seleccione una fecha de descarga.\n";
    }
    //*-------------------------------------------------------------------- Campaña
    if (rxMovimientoInternoItem.value.campania == null ||
        rxMovimientoInternoItem.value.campania!.afipCampaniaId == null ||
        rxMovimientoInternoItem.value.campania!.afipCampaniaId == -1)
    {
      _errorMessage += "Seleccione una Campaña.\n";
    }
    //*-------------------------------------------------------------------- Especie
    if (rxMovimientoInternoItem.value.especie == null ||
        rxMovimientoInternoItem.value.especie!.especieId == null ||
        rxMovimientoInternoItem.value.especie!.especieId == -1)
    {
      _errorMessage += "Seleccione una Especie.\n";
    }
    //*-------------------------------------------------------------------- Exp Agropecuaria
    if (rxMovimientoInternoItem.value.ea == null ||
        rxMovimientoInternoItem.value.ea!.clienteId == null ||
        rxMovimientoInternoItem.value.ea!.clienteId == -1)
    {
      _errorMessage += "Seleccione una Exp.Agropecuaria.\n";
    }
    //*-------------------------------------------------------------------- Lote
    if (rxMovimientoInternoItem.value.lote == null ||
        rxMovimientoInternoItem.value.lote!.loteId == null ||
        rxMovimientoInternoItem.value.lote!.loteId == -1)
    {
      _errorMessage += "Seleccione un Lote.\n";
    }
    //*-------------------------------------------------------------------- UA
    if (rxMovimientoInternoItem.value.ua == null ||
        rxMovimientoInternoItem.value.ua!.uaId == null ||
        rxMovimientoInternoItem.value.ua!.uaId == -1)
    {
      _errorMessage += "Seleccione una Unidad de Almacenamiento.\n";
    }
    //*-------------------------------------------------------------------- Cantidad
    if (rxMovimientoInternoItem.value.cantidad == null ||
        rxMovimientoInternoItem.value.cantidad! <= 0.0)
    {
      _errorMessage += "Ingrese la cantidad de Kgs.\n";
    }

    return _errorMessage.isEmpty;
  }
  
  //*----------------------------------------------------------------------------------- Filtrar UAs
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
        await guardarMovimientoInterno();
        saving.toggle();
        Get.back();

        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Listo'),
            titleTextStyle: const TextStyle(fontSize: 18, color: kTLightPrimaryColor1),
            content: const Text('El Movimiento fue guardado correctamente !'),
            contentTextStyle: const TextStyle(fontSize: 16, color: kTLightPrimaryColor1),
            actions: [
              TextButton(
                style: kTButtonStyle,
                child: const Text("Cerrar"),
                //onPressed: () => Get.until((route) => Get.currentRoute == AppRoutes.rMovInternoList),
                onPressed: () { 
                  if (Get.isDialogOpen!) 
                  {
                    Get.back(closeOverlays: true);
                  }
                  Get.back(result: true, closeOverlays: true);}
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
  
  
  //*----------------------------------------------------------------------------------- Campania Seleccionada
  int getCampaniaId() { 
    int returnValue = 0;
    if (rxMovimientoInternoItem.value.campania != null) { returnValue = rxMovimientoInternoItem.value.campania!.afipCampaniaId!; }
    return returnValue;
  }
  Campania getCampania() { 
    Campania returnValue = Campania();
    if (rxMovimientoInternoItem.value.campania != null) { returnValue = rxMovimientoInternoItem.value.campania!; }
    return returnValue;
  }
  void setCampania(Campania c, bool refreshCombos) async {
    if ((rxMovimientoInternoItem.value.campania == null) || 
        (rxMovimientoInternoItem.value.campania != null && c.afipCampaniaId != rxMovimientoInternoItem.value.campania!.afipCampaniaId))
    {
      //?-- Seteo solo si se cambio la campaña
      rxMovimientoInternoItem.value.campania = c; 
      if (refreshCombos)
      {
        rxMovimientoInternoItem.value.especie = especieSinSeleccion;
        rxMovimientoInternoItem.value.ea = eaSinSeleccion;
        rxMovimientoInternoItem.value.lote = loteSinSeleccion;
        rxMovimientoInternoItem.value.ua = uaSinSeleccion;
      }
      rxMovimientoInternoItem.refresh();
    }
  }

  //*----------------------------------------------------------------------------------- Especie Seleccionada
  int getEspecieId() { 
    int returnValue = 0;
    if (rxMovimientoInternoItem.value.especie != null) { returnValue = rxMovimientoInternoItem.value.especie!.especieId!; }
    return returnValue;
  }
  Especie getEspecie() { 
    Especie returnValue = especieSinSeleccion;
    if (rxMovimientoInternoItem.value.especie != null) { returnValue = rxMovimientoInternoItem.value.especie!; }
    return returnValue;
  }
  void setEspecie(Especie e, bool refreshCombos) { 
    if ((rxMovimientoInternoItem.value.especie == null) || 
        (rxMovimientoInternoItem.value.especie != null && e.especieId != rxMovimientoInternoItem.value.especie!.especieId))
    {
      //?-- Seteo solo si se cambio la especie
      rxMovimientoInternoItem.value.especie = e; 
      if (refreshCombos)
      {
        rxMovimientoInternoItem.value.ea = eaSinSeleccion;
        rxMovimientoInternoItem.value.lote = loteSinSeleccion;
        rxMovimientoInternoItem.value.ua = uaSinSeleccion;
      }
      rxMovimientoInternoItem.refresh();
    } //-- Piso para pedir los lotes que tengan esta especie
  }

  //*----------------------------------------------------------------------------------- Explotacion Agropecuaria
  int getExpAgropecuariaId() { 
    int returnValue = 0;
    if (rxMovimientoInternoItem.value.ea != null) { returnValue = rxMovimientoInternoItem.value.ea!.clienteId!; }
    return returnValue;
  }
  ExplotacionAgropecuaria getExpAgropecuaria() { 
    ExplotacionAgropecuaria returnValue = eaSinSeleccion;
    if (rxMovimientoInternoItem.value.ea != null) { returnValue = rxMovimientoInternoItem.value.ea!; }
    return returnValue;
  }
  void setExpAgropecuaria(ExplotacionAgropecuaria ea, bool refreshCombos) { 
    if ((rxMovimientoInternoItem.value.ea == null) || 
        (rxMovimientoInternoItem.value.ea != null && ea.clienteId != rxMovimientoInternoItem.value.ea!.clienteId))
    {
      rxMovimientoInternoItem.value.ea = ea; 
      if (refreshCombos)
      {
        rxMovimientoInternoItem.value.lote = loteSinSeleccion;
        rxMovimientoInternoItem.value.ua = uaSinSeleccion;
      }
      rxMovimientoInternoItem.refresh();
    } //-- Piso para pedir los lotes que tengan esta especie
  }

  //*----------------------------------------------------------------------------------- Lote
  int getLoteId() { 
    int returnValue = 0;
    if (rxMovimientoInternoItem.value.lote != null) { returnValue = rxMovimientoInternoItem.value.lote!.loteId!; }
    return returnValue;
  }
  Lote getLote() { 
    Lote returnValue = loteSinSeleccion;
    if (rxMovimientoInternoItem.value.lote != null) { returnValue = rxMovimientoInternoItem.value.lote!; }
    return returnValue;
  }
  void setLote(Lote l, bool refreshCombos) { 
    if ((rxMovimientoInternoItem.value.lote == null) || 
        (rxMovimientoInternoItem.value.lote != null && l.loteId != rxMovimientoInternoItem.value.lote!.loteId))
    {
      rxMovimientoInternoItem.value.lote = l; 
      rxMovimientoInternoItem.refresh();
    } //-- Piso para pedir los lotes que tengan esta especie
  }

  
  //*----------------------------------------------------------------------------------- UA
  int getUaId() { 
    int returnValue = 0;
    if (rxMovimientoInternoItem.value.ua != null) { returnValue = rxMovimientoInternoItem.value.ua!.uaId!; }
    return returnValue;
  }
  UA getUa() { 
    UA returnValue = uaSinSeleccion;
    if (rxMovimientoInternoItem.value.ua != null) { returnValue = rxMovimientoInternoItem.value.ua!; }
    return returnValue;
  }
  void setUa(UA u, bool refreshCombos) { 
    if ((rxMovimientoInternoItem.value.ua == null) || 
        (rxMovimientoInternoItem.value.ua != null && u.uaId != rxMovimientoInternoItem.value.ua!.uaId))
    {
      rxMovimientoInternoItem.value.ua = u; 
      rxMovimientoInternoItem.refresh();
    } //-- Piso para pedir los lotes que tengan esta especie
  }

  //*----------------------------------------------------------------------------------- Kilos
  double getCantidad() { 
    double returnValue = 0.0;
    if (rxMovimientoInternoItem.value.cantidad != null) { returnValue = rxMovimientoInternoItem.value.cantidad!; }
    return returnValue;
  }
  void setCantidad(String c) { 
    if ((rxMovimientoInternoItem.value.cantidad == null) || 
        (rxMovimientoInternoItem.value.cantidad != null && double.parse(c)!= rxMovimientoInternoItem.value.cantidad))
    {
      txtCantidadController.text = c;
      rxMovimientoInternoItem.value.cantidad = double.parse(c); 
      rxMovimientoInternoItem.refresh();
    } //-- Piso para pedir los lotes que tengan esta especie
  }

  //*----------------------------------------------------------------------------------- fecha de descarga
  DateTime get movFechaDeDescarga { return rxMovimientoInternoItem.value.fechaDescarga!; }
  set movFechaDeDescarga(DateTime _fd) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    txtFechaDescargaController.text = formatter.format(_fd).toString();
    rxMovimientoInternoItem.value.fechaDescarga = _fd;
  }
}