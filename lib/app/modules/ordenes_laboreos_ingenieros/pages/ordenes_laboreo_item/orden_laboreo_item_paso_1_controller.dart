import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/model/mov_interno_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/articulos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_controller.dart';
import 'orden_laboreo_item_provider.dart';

class OrdenLaboreoItemPaso1Controller extends GetxController {

  OrdenLaboreoItemPaso1Controller();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  FormMode mode = FormMode.none;

  EAResourcesRequest paramReqEAResources = EAResourcesRequest();

  late OrdenesLaboreosResumenDeIngenieroItem itemResumen;

  final MenuIngenierosController recursosEAController = Get.find<MenuIngenierosController>();
  final OrdenLaboreoItemProvider _provider = Get.find<OrdenLaboreoItemProvider>();

  Rx<TextEditingController> txtOrdenLaboreoIdController = TextEditingController().obs;
  Rx<TextEditingController> txtFechaEmisionController   = TextEditingController().obs;
  Rx<TextEditingController> txtFechaVtoController       = TextEditingController().obs;
  final TextEditingController txtEstadoController       = TextEditingController();

  Especie especieSinSeleccion = Especie(especieId: -1, nombre: '');
  Ingeniero ingenieroSinSeleccion = Ingeniero(clienteId: -1, nombre: '');
  Contratista contratistaSinSeleccion = Contratista(clienteId: -1, nombre: '');
  ExplotacionAgropecuaria eaSinSeleccion = ExplotacionAgropecuaria(clienteId: -1, clienteNombre: '');
  UA uaSinSeleccion = UA(uaId: -1, uaNombre: '');

  Rx<bool> saving = false.obs;

  // * ----------------------------------------------------------------------------- ORDEN DE LABOREO OBSERVABLE
  Rx<OLAbm> rxOLAbm = OLAbm().obs;

  int pOlId = -1;

  String accion = '';    //!-- Add Cerrar OL

  // * ----------------------------------------------------------------------------- onInit
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    pOlId = Get.arguments["ordenLaboreoId"] as int;
    paramReqEAResources = Get.arguments["requestEARerources"] as EAResourcesRequest;
    mode = pOlId == -1 ? FormMode.insert : FormMode.update;
    accion = Get.arguments["accion"] ?? '';         //!-- Add Cerrar OL
    super.onInit();
  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    if (mode == FormMode.insert)
    {
      //?====================================================================================
      //?-- INSERT de OL - Seteo valores por default !
      //?====================================================================================
      setOlId(recursosEAController.recursosEA.nextOlId);
      setFecEmi(DateTime.now());
      setFecVto(DateTime.now().add(const Duration(days: 30)));
      setEstado('PENDIENTE');
      setCampania(recursosEAController.recursosEA.campanias[0], true);   //-- Aca tengo las 2 campanias que tengo que mostrar!
      rxOLAbm.value.gEconomicoId = paramReqEAResources.gEconomicoId;
      rxOLAbm.value.empresaId = paramReqEAResources.empresaId;
      rxOLAbm.value.tipoCambio = recursosEAController.recursosEA.cotizacionDolar;
      rxOLAbm.value.precioHaDolar = 0.0;
      rxOLAbm.value.precioHaPesos = 0.0;
      rxOLAbm.value.observacion = '';

      //*-- en INSERT seteo el ingeniero
      itemResumen = Get.arguments["itemResumen"] as OrdenesLaboreosResumenDeIngenieroItem;
      if (itemResumen.ingenieroId > 0)
      {
        setIngeniero(Ingeniero(clienteId: itemResumen.ingenieroId, nombre: itemResumen.ingeniero));
      }

      //*-- Si existe una unica UAO la asigno
      if (recursosEAController.recursosEA.uasOrigen.length == 1)
      {
        setUaOrigen(UA(uaId: recursosEAController.recursosEA.uasOrigen[0].uaId, uaNombre: recursosEAController.recursosEA.uasOrigen[0].uaNombre));
      }
    }
    else
    {
      try {
        Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
        //?====================================================================================
        //?-- EDICION de OL
        //?====================================================================================
        OLAbm ol = await _provider.obtenerOLAbm(
                                        OLAbmRequest(
                                          empresaId: recursosEAController.itemResumen.empresaId,
                                          gEconomicoId: recursosEAController.itemResumen.gEconomicoId,
                                          olId: pOlId,
                                          tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco
                                        ));

        rxOLAbm.value.gEconomicoId = paramReqEAResources.gEconomicoId;
        rxOLAbm.value.empresaId = paramReqEAResources.empresaId;
        setOlId(pOlId);
        setEstado(ol.estado!);
        setCampania(ol.campania!, true);   //-- Aca tengo las 2 campanias que tengo que mostrar!
        setFecEmi(ol.fecEmi!);
        setFecVto(ol.fecVto!);
        setIngeniero(ol.ingeniero!);
        setExpAgropecuaria(ol.ea!, true);
        setUaOrigen(ol.uaOrigen!);
        setUaDestino(ol.uaDestino!);
        rxOLAbm.value.contratista = ol.contratista!;
        rxOLAbm.value.laboreo = ol.laboreo!;
        rxOLAbm.value.tipoCambio = ol.tipoCambio!;
        rxOLAbm.value.precioHaPesos = ol.precioHaPesos!;
        rxOLAbm.value.precioHaDolar = ol.precioHaDolar!;
        rxOLAbm.value.observacion = ol.observacion!;
        rxOLAbm.value.totalInsumos = ol.totalInsumos;
        rxOLAbm.value.lotes = ol.lotes;
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
  bool isValidPaso1() {

    _errorMessage = '';

    //* Campaña
    if (rxOLAbm.value.campania == null || rxOLAbm.value.campania!.afipCampaniaId == null || rxOLAbm.value.campania!.afipCampaniaId == -1)  _errorMessage += "Falta la Campaña.\n";

    //* Especie
    // if (mode == FormMode.insert)
    // {
    //   if (rxOLAbm.value.especie == null || rxOLAbm.value.especie!.especieId == null || rxOLAbm.value.especie!.especieId == -1) _errorMessage += "Falta la Especie.\n";
    // }

    //* Fecha de emisión
    if (rxOLAbm.value.fecEmi == null) _errorMessage += "Falta la fecha de emisión.\n";

    //* Fecha de vencimiento
    if (rxOLAbm.value.fecVto == null) _errorMessage += "Falta la fecha de vencimiento.\n";
    if (rxOLAbm.value.fecEmi != null && rxOLAbm.value.fecVto != null && rxOLAbm.value.fecEmi!.compareTo(rxOLAbm.value.fecVto!) > 0) _errorMessage += "La fecha de emisión debe ser menor a la de vencimiento.\n";

    //* Ingeniero
    if (rxOLAbm.value.ingeniero == null || rxOLAbm.value.ingeniero!.clienteId == null || rxOLAbm.value.ingeniero!.clienteId == -1) _errorMessage += "Falta el Ingeniero.\n";

    //* Exp Agropecuaria
    if (rxOLAbm.value.ea == null || rxOLAbm.value.ea!.clienteId == null || rxOLAbm.value.ea!.clienteId == -1) _errorMessage += "Falta la Exp.Agropecuaria.\n";

    //* UA Origen
    if (rxOLAbm.value.uaOrigen == null || rxOLAbm.value.uaOrigen!.uaId == null || rxOLAbm.value.uaOrigen!.uaId == -1) _errorMessage += "Falta la Unidad de Alm. Origen.\n";

    //* UA Destino
    if (rxOLAbm.value.uaDestino == null || rxOLAbm.value.uaDestino!.uaId == null || rxOLAbm.value.uaDestino!.uaId == -1) _errorMessage += "Falta la Unidad de Alm. Destino.\n";

    return _errorMessage.isEmpty;
  }

  //*----------------------------------------------------------------------------------- GO PASO 2
  void goPaso2() async {

    try {

      if (!isValidPaso1())
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
        if (mode == FormMode.insert)
        {
          //*------------------------------- INSERT
          Get.toNamed(AppRoutes.rOlPaso2,
                    arguments: {
                      "requestEARerources": paramReqEAResources,
                      "ordenLaboreoId":     -1,
                      "accion":             accion,
                    });
        }
        else if (mode == FormMode.update)
        {
          //*------------------------------- UPDATE
          Get.toNamed(AppRoutes.rOlPaso2,
                    arguments: {
                      "requestEARerources": paramReqEAResources,
                      "ordenLaboreoId":     pOlId,
                      "accion":             accion,
                    });
        }
       
      }

      _errorMessage = '';
    }
    catch(e) {
      //saving.toggle();
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }

  // * ----------------------------------------------------------------------------- obtenerEACampania
  Future<List<ExplotacionAgropecuaria>> obtenerEACampania(EAResourcesRequest req) async {
    List<ExplotacionAgropecuaria> listaEA = [];
    try {
      listaEA = await _provider.obtenerEACampania(req);
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaEA;
  }

  //*----------------------------------------------------------------------------------- obtenerEACampaniaEspecie
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

  //*----------------------------------------------------------------------------------- obtenerEspeciesEnCampania
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

  //*----------------------------------------------------------------------------------- obtenerUADestino
  Future<List<UA>> obtenerUADestino(EAUaDestinoRequest req) async {
    List<UA> destinos = [];
    try {
      destinos = await _provider.obtenerUADestino(req);
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return destinos;
  }

  //*----------------------------------------------------------------------------------- OLId
  int getOlId() {
    int returnValue = 0;
    if (rxOLAbm.value.olId != null) { returnValue = rxOLAbm.value.olId!; }
    return returnValue;
  }
  setOlId(int olId) {
    if (rxOLAbm.value.olId == null || olId != rxOLAbm.value.olId)
    {
      txtOrdenLaboreoIdController.value.text = olId.toString();
      rxOLAbm.value.olId = olId;
      rxOLAbm.refresh();
    }
  }

  //*----------------------------------------------------------------------------------- fecha de Emision
  DateTime getFecEmi() { return rxOLAbm.value.fecEmi!; }
  setFecEmi(DateTime _fe) {
    txtFechaEmisionController.value.text = formatter.format(_fe).toString();
    rxOLAbm.value.fecEmi = _fe;
  }

  //*----------------------------------------------------------------------------------- fecha de Vto
  DateTime getFecVto() { return rxOLAbm.value.fecVto!; }
  setFecVto(DateTime _fv) {
    txtFechaVtoController.value.text = formatter.format(_fv).toString();
    rxOLAbm.value.fecVto = _fv;
  }

  //*----------------------------------------------------------------------------------- estado
  String getEstado() { return rxOLAbm.value.estado!; }
  setEstado(String _estado) {
    txtEstadoController.text = _estado.toUpperCase();
    rxOLAbm.value.estado = _estado;
  }

  //*----------------------------------------------------------------------------------- Explotacion Agropecuaria
  int getExpAgropecuariaId() {
    int returnValue = 0;
    if (rxOLAbm.value.ea != null) { returnValue = rxOLAbm.value.ea!.clienteId!; }
    return returnValue;
  }
  ExplotacionAgropecuaria getExpAgropecuaria() {
    ExplotacionAgropecuaria returnValue = eaSinSeleccion;
    if (rxOLAbm.value.ea != null) { returnValue = rxOLAbm.value.ea!; }
    return returnValue;
  }
  Future<void> setExpAgropecuaria(ExplotacionAgropecuaria ea, bool refreshCombos) async {
    if ((rxOLAbm.value.ea == null) ||
        (rxOLAbm.value.ea != null && ea.clienteId != rxOLAbm.value.ea!.clienteId))
    {
      rxOLAbm.value.ea = ea;
      if (refreshCombos)
      {
        rxOLAbm.value.uaOrigen = uaSinSeleccion;
        rxOLAbm.value.uaDestino = uaSinSeleccion;

        if (mode == FormMode.insert)
        {
          //*-- Agregado 2022-09-20 si solo tengo una UA origen la seteo al toque
          if (recursosEAController.recursosEA.uasOrigen.length == 1)
          {
            setUaOrigen(UA(uaId: recursosEAController.recursosEA.uasOrigen[0].uaId, uaNombre: recursosEAController.recursosEA.uasOrigen[0].uaNombre));
          }

          //*-- Agregado 2022-09-20 para traer la ua destino si solo tenemos una 
          List<UA> listUaDestino = await obtenerUADestino(EAUaDestinoRequest(
                      gEconomicoId: paramReqEAResources.gEconomicoId,
                      empresaId: paramReqEAResources.empresaId,
                      tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                      clienteId: ea.clienteId!));

          if (listUaDestino.length == 1)
          {
            setUaDestino(UA(uaId: listUaDestino[0].uaId, uaNombre: listUaDestino[0].uaNombre));
          }
        }

      }

      //?-- Si cambio de EA limpio los lotes
      rxOLAbm.value.lotes = [];

      rxOLAbm.refresh();
    }
  }


  //*----------------------------------------------------------------------------------- Campania Seleccionada
  int getCampaniaId() {
    int returnValue = 0;
    if (rxOLAbm.value.campania != null) { returnValue = rxOLAbm.value.campania!.afipCampaniaId!; }
    return returnValue;
  }
  Campania getCampania() {
    Campania returnValue = Campania();
    if (rxOLAbm.value.campania != null)
      { returnValue = rxOLAbm.value.campania!; }
    else
      { returnValue = recursosEAController.recursosEA.campanias[0]; }

    return returnValue;
  }
  void setCampania(Campania c, bool refreshCombos) async {
    if ((rxOLAbm.value.campania == null) ||
        (rxOLAbm.value.campania != null && c.afipCampaniaId != rxOLAbm.value.campania!.afipCampaniaId))
    {
      //?-- Seteo solo si se cambio la campaña
      rxOLAbm.value.campania = c;
      if (refreshCombos)
      {
        rxOLAbm.value.ea = eaSinSeleccion;
        rxOLAbm.value.uaOrigen = uaSinSeleccion;
        rxOLAbm.value.uaDestino = uaSinSeleccion;
      }
      rxOLAbm.refresh();
    }
  }

  //*----------------------------------------------------------------------------------- Ingeniero
  int getIngenieroId() {
    int returnValue = 0;
    if (rxOLAbm.value.ingeniero != null) { returnValue = rxOLAbm.value.ingeniero!.clienteId!; }
    return returnValue;
  }
  Ingeniero getIngeniero() {
    Ingeniero returnValue = ingenieroSinSeleccion;
    if (rxOLAbm.value.ingeniero != null) { returnValue = rxOLAbm.value.ingeniero!; }
    return returnValue;
  }
  void setIngeniero(Ingeniero i) {
    if ((rxOLAbm.value.ingeniero == null) ||
        (rxOLAbm.value.ingeniero != null && i.clienteId != rxOLAbm.value.ingeniero!.clienteId))
    {
      //?-- Seteo solo si se cambio el ingeniero
      rxOLAbm.value.ingeniero = i;
      rxOLAbm.refresh();
    }
  }


  //*----------------------------------------------------------------------------------- UA Origen
  int getUaOrigenId() {
    int returnValue = 0;
    if (rxOLAbm.value.uaOrigen != null) { returnValue = rxOLAbm.value.uaOrigen!.uaId!; }
    return returnValue;
  }
  UA getUaOrigen() {
    UA returnValue = UA();
    if (rxOLAbm.value.uaOrigen != null)
      { returnValue = rxOLAbm.value.uaOrigen!; }
    else
      { returnValue = uaSinSeleccion; }

    return returnValue;
  }
  void setUaOrigen(UA u) async {
    if ((rxOLAbm.value.uaOrigen == null) ||
        (rxOLAbm.value.uaOrigen != null && u.uaId != rxOLAbm.value.uaOrigen!.uaId))
    {
      //?-- Si cambio la UAOrigen limpio los insumos de todos los lotes
      for (var lote in rxOLAbm.value.lotes) {
        lote.insumos = [];
      }

      //?-- Seteo solo si se cambio la campaña
      rxOLAbm.value.uaOrigen = u;
      rxOLAbm.refresh();
    }
  }


  //*----------------------------------------------------------------------------------- UA Destino
  int getUaDestinoId() {
    int returnValue = 0;
    if (rxOLAbm.value.uaDestino != null) { returnValue = rxOLAbm.value.uaDestino!.uaId!; }
    return returnValue;
  }
  UA getUaDestino() {
    UA returnValue = UA();
    if (rxOLAbm.value.uaDestino != null)
      { returnValue = rxOLAbm.value.uaDestino!; }
    else
      { returnValue = uaSinSeleccion; }

    return returnValue;
  }
  void setUaDestino(UA u) async {
    if ((rxOLAbm.value.uaDestino == null) ||
        (rxOLAbm.value.uaDestino != null && u.uaId != rxOLAbm.value.uaDestino!.uaId))
    {
      //?-- Seteo solo si se cambio la campaña
      rxOLAbm.value.uaDestino = u;
      rxOLAbm.refresh();
    }
  }

  //*----------------------------------------------------------------------------------- Contratistas
  int getContratistaId() {
    int returnValue = 0;
    if (rxOLAbm.value.contratista != null) { returnValue = rxOLAbm.value.contratista!.clienteId!; }
    return returnValue;
  }
  Contratista getContratista() {
    Contratista returnValue = contratistaSinSeleccion;
    if (rxOLAbm.value.contratista != null) { returnValue = rxOLAbm.value.contratista!; }
    return returnValue;
  }
  void setContratista(Contratista c) {
    if ((rxOLAbm.value.contratista == null) ||
        (rxOLAbm.value.contratista != null && c.clienteId != rxOLAbm.value.contratista!.clienteId))
    {
      //?-- Seteo solo si se cambio el contratista
      rxOLAbm.value.contratista = c;
      rxOLAbm.refresh();
    }
  }




  //*----------------------------------------------------------------------------------- Actualizo total de insumos
  actualizarTotalArticulo(Articulo a) {

    double _gastoTotal = 0.0;
    //*-- Elimino de la lista de total de insumos el articulo 

    List<OLAbmTotalInsumo> totalDeInsumos = rxOLAbm.value.totalInsumos.where((i) => i.articuloId == a.articuloFacId).toList();
    if (totalDeInsumos.isNotEmpty)
    {
      rxOLAbm.value.totalInsumos.removeWhere((i) => i.articuloId == a.articuloFacId);
    }

    //*-- Sumarizo el total del insummo en todos los lotes
    for (Lote lote in rxOLAbm.value.lotes)
    {
      if (lote.seleccionado!)
      {
        List<OLAbmInsumoLote> listaInsumo = lote.insumos!.where((i) => i.articuloId == a.articuloFacId).toList();
        if (listaInsumo.isNotEmpty)
        {
          _gastoTotal += listaInsumo[0].total!;
        }
      }
    }

    _gastoTotal = double.parse(_gastoTotal.toStringAsFixed(2));

    //*-- Si el gasto total es > 0 agrego a total insumos
    if (_gastoTotal > 0)
    {
      OLAbmTotalInsumo nuevoInsumo = OLAbmTotalInsumo(
        articuloId: a.articuloFacId,
        nombre: a.nombre!,
        total: _gastoTotal,
        umo: a.umOrigen,
        idUnico: a.idUnico,
        entregado: _gastoTotal,  //-- el total = entregado => saldo = 0
        saldo: 0,
      );

      //* -- agregar elemento a la lista SIN ERROR - peperina
      rxOLAbm.value.totalInsumos = [ ...rxOLAbm.value.totalInsumos, nuevoInsumo ];
    }
    

    actualizarCosteo();

  }

  //*----------------------------------------------------------------------------------- getTotalHasATrabajar
  getTotalHasATrabajar() {
    double _totalHasATrabajar = 0.0;
    for (Lote lote in rxOLAbm.value.lotes)
    {
      if (lote.seleccionado!)
      {
        _totalHasATrabajar += lote.cantHasTrabajadas!;
      }
    }
    return _totalHasATrabajar;
  }

  //*----------------------------------------------------------------------------------- Actualizo COSTEO
  actualizarCosteo() {
    rxOLAbm.value.totalPesos = getTotalHasATrabajar() * rxOLAbm.value.precioHaPesos!;
    rxOLAbm.value.totalDolar = getTotalHasATrabajar() * rxOLAbm.value.precioHaDolar!;
  }

  //*----------------------------------------------------------------------------------- Actualizo totales
  actualizarTotal() {

    //*-- Elimino de la lista de total de insumos el articulo agregado para resumarizar

    //*- limpio y la genero de nuevo
    rxOLAbm.value.totalInsumos = [];
    double totalHasATrabajar = 0.0;

    //*-- Recorro los lotes
    for (Lote lote in rxOLAbm.value.lotes)
    {
      if (lote.seleccionado!)
      {
        totalHasATrabajar += lote.cantHasTrabajadas ?? 0.0;

        //*-- Recorro los insumos de cada lote
        for (var insumo in lote.insumos!)
        {
          //*-- Busco el insumo en el total de insumos
          List<OLAbmTotalInsumo> totalDeInsumos = rxOLAbm.value.totalInsumos.where((i) => i.articuloId == insumo.articuloId).toList();
          if (totalDeInsumos.isNotEmpty)
          {
            totalDeInsumos[0].total += insumo.total!;
            totalDeInsumos[0].entregado += insumo.total!;
          }
          else
          {
            //*-- Agrego insumo
            OLAbmTotalInsumo nuevoInsumo = OLAbmTotalInsumo(
                      articuloId: insumo.articuloId!,
                      nombre: insumo.nombre!,
                      total:  insumo.total!,
                      umo: insumo.umOrigen!,
                      idUnico: insumo.idUnico!,
                      entregado: insumo.total!,  //-- el total = entregado => saldo = 0
                      saldo: 0,
            );

            //*-- agregar elemento a la lista SIN ERROR - peperina
            rxOLAbm.value.totalInsumos = [ ...rxOLAbm.value.totalInsumos, nuevoInsumo ];
          }
        }
      }
    }
    rxOLAbm.value.cantTotalHas = totalHasATrabajar;
    actualizarCosteo();

  }



}