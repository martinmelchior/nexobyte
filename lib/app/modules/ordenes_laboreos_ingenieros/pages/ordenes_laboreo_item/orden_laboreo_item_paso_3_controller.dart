import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/ea_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/articulos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_controller.dart';
import 'orden_laboreo_item_paso_1_controller.dart';
import 'orden_laboreo_item_provider.dart';

class OrdenLaboreoItemPaso3Controller extends GetxController {

  OrdenLaboreoItemPaso3Controller();

  FormMode mode = FormMode.none;
  
  EAResourcesRequest paramReqEAResources = EAResourcesRequest();

  final OrdenLaboreoItemPaso1Controller paso1Controller = Get.find<OrdenLaboreoItemPaso1Controller>();
  final MenuIngenierosController recursosEAController = Get.find<MenuIngenierosController>();
  final OrdenLaboreoItemProvider _provider = Get.find<OrdenLaboreoItemProvider>();

  TextEditingController txtCantHasController = TextEditingController();
  TextEditingController txtTotalAConsumir = TextEditingController();
  Rx<bool> saving = false.obs;
  Rx<bool> hasTrabajadasOk = true.obs;

  String accion = '';    //!-- Add Cerrar OL
  
  // * ----------------------------------------------------------------------------- onInit
  @override
  void onInit()  {
    super.onInit();
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pOlId = Get.arguments["ordenLaboreoId"] as int;
    paramReqEAResources = Get.arguments["requestEARerources"] as EAResourcesRequest;
    mode = pOlId == -1 ? FormMode.insert : FormMode.update; 
    accion = Get.arguments["accion"] ?? '';         //!-- Add Cerrar OL
  }

  
  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    try {
      if (mode == FormMode.insert && paso1Controller.rxOLAbm.value.lotes.isEmpty)
      { 
        //?====================================================================================
        //?-- INSERT de OL - Seteo valores por default !
        //?====================================================================================
        LotesPorCampaniaEARequest req = LotesPorCampaniaEARequest(
          gEconomicoId: paramReqEAResources.gEconomicoId,
          empresaId: paramReqEAResources.empresaId,
          afipCampaniaId: paso1Controller.rxOLAbm.value.campania!.afipCampaniaId!,
          clienteId: paso1Controller.rxOLAbm.value.ea!.clienteId!,
        );
        Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
        paso1Controller.rxOLAbm.value.lotes = await obtenerLotesPorCampaniaEA(req);
        Get.back();

        for (var l in paso1Controller.rxOLAbm.value.lotes)           
        {
          l.seleccionado = true;
          l.cantHasTrabajadas = l.cantHas;
        }
        paso1Controller.actualizarCosteo();
        paso1Controller.rxOLAbm.refresh();
        
      }
      else if (mode == FormMode.update) {
        
      }
      super.onReady();
    } 
    catch(e) {
      Get.back();
      ApiExceptions.procesarError(e);
    }
  }

  //*-------------------------------------------------------------------- Validacion de controles
  String _errorMessage = '';
  bool isValidPaso3() {
    _errorMessage = '';
    return _errorMessage.isEmpty;
  }

  //*----------------------------------------------------------------------------------- Filtrar UAs
  void save(accion) async {       //!-- Add Cerrar OL

    try {

      if (!isValidPaso3())
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

        String mensaje = "";
        bool goBackToList = true;       //*-- Default cierra normal, es decir se va a la LIST

        if (mode == FormMode.insert)
        {
          //*- INSERT
          mensaje = "La OL fue creada correctamente !";
          await _provider.insertarOL(paso1Controller.rxOLAbm.value);
        }
        else if (mode == FormMode.update)
        {
          //!-- Add Cerrar OL
          if (accion == "CERRAR")
          {
            //*-- Generamos los asientos para ver si los mostramos o no
            //*-- tener en cuenta que este metodo graba la OL con las modificaciones si se hicieron en los totale de insumos
            ObtenerAsientosContablesOLResponse listaAsientos = await _provider.showAsientosOL(paso1Controller.rxOLAbm.value);
            if (listaAsientos.listaAsientosContables.isEmpty)
            {
              //*-- Llamar a metodo CERRAR ya que no hay asientos generados pero el usuario dio a CERRAR OL
              mensaje = "La OL fue CERRADA correctamente !";
              await _provider.cerrarOL(paso1Controller.rxOLAbm.value);
            }
            else 
            {
              //*-- Llamamos a pantalla para MOSTRAR LOS ASIENTOS y pedimos confirmacion de CIERRE
              bool cerrarOL = await Get.toNamed(AppRoutes.rAsientosContablesOl, arguments: listaAsientos);
              if (cerrarOL)
              {
                //*-- Llamar a metodo CERRAR 
                mensaje = "La OL fue CERRADA correctamente !";
                await _provider.cerrarOL(paso1Controller.rxOLAbm.value);
              }
              else
              {
                //*-- Cancelo el CIERRE de la OL, me quedo donde estoy
                goBackToList = false;
              }
            }
          }
          else
          {
            //*- UPDATE
            mensaje = "La OL fue actualizada correctamente !";
            await _provider.updateOL(paso1Controller.rxOLAbm.value);
          }
        }

        if (goBackToList)
        {
          Get.back();
          Get.close(4);

          Get.snackbar("LISTO", mensaje,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.error, color: Colors.white),
            backgroundColor: Colors.green,
            colorText: Colors.white,
            borderRadius: 0.0,
            margin: const EdgeInsets.all(0),
          );
        }
        else
        {
          saving.toggle();
          Get.back();
        }
      }
      _errorMessage = '';
    } 
    catch(e) {
      saving.toggle();
      Get.back();
      ApiExceptions.procesarError(e);
    }
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


  //*----------------------------------------------------------------------------------- Filtrar LOTES por campaña
  Future<List<Lote>> obtenerLotesPorCampaniaEA(LotesPorCampaniaEARequest req) async {
    List<Lote> listaLotes = [];
    try {
      LotesPorCampaniaEAResponse result = await _provider.obtenerLotesPorCampaniaEA(
                                                            LotesPorCampaniaEARequest(
                                                              gEconomicoId:   req.gEconomicoId,
                                                              empresaId:      req.empresaId,
                                                              clienteId:      req.clienteId,
                                                              afipCampaniaId: req.afipCampaniaId,
                                                            ));

      listaLotes = result.lotes;
    } 
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaLotes;
  }


  //*----------------------------------------------------------------------------------- Busca el Lote en la Lista 
  Lote buscarLoteEnLista(int loteId, int loteExplotacionId) {
    //-- Fix Lote Explotacion
    return paso1Controller.rxOLAbm.value.lotes.firstWhere((l) => l.loteId == loteId && l.explotacionLoteId == loteExplotacionId);
  }
  

  //*----------------------------------------------------------------------------------- MARCA / DESMARCA LOTE
  //-- Fix Lote Explotacion
  void marcarDesmarcarLote(bool marcaDesmarca, int loteId, int loteExplotacionId) {

    //-- Fix Lote Explotacion
    Lote l = buscarLoteEnLista(loteId, loteExplotacionId);
    if (l.loteId != -1)
    {
      //*--- Actualizo el estado de marca
      l.seleccionado = marcaDesmarca;

      if (marcaDesmarca == false)
      {
        //*--- si desmarque no debe sumar la cantidad de has trabajadas
        l.cantHasTrabajadas = 0.0;
      }

      if (marcaDesmarca == false && l.insumos!.isNotEmpty)
      {
        //*-------------- Si desmarca y tiene insumos los limpio
        l.insumos = [];
        Get.showSnackbar(const GetSnackBar(
                      backgroundColor: kTRedColor,
                      snackPosition: SnackPosition.TOP,
                      title: 'LOTE ELIMINADO',
                      isDismissible: true,
                      message: "Al desmarcar el lote no se asignarán los insumos y no se guardará como parte de la Orden de Laboreo!",
                      duration: Duration(seconds: 5)));
      }

      if (marcaDesmarca && l.cantHasTrabajadas == 0.0)
      {
        //*-------------- Si marca y tiene has trabajadas aviso por las dudas
        Get.showSnackbar(const GetSnackBar(
                      backgroundColor: kTRedColor,
                      snackPosition: SnackPosition.TOP,
                      title: 'ATENCION',
                      isDismissible: true,
                      message: "Recuerde modificar la cantidad de has a trabajar !\nEn este momento es CERO !",
                      duration: Duration(seconds: 5)));
      }
    }
    
  }

  //*----------------------------------------------------------------------------------- Seteo Has Trabajadas del lote
  //-- Fix Lote Explotacion
  setHectareasTrabajadasALote(int loteId, int loteExplotacionId, double has) {

    //-- Fix Lote Explotacion
    Lote l = buscarLoteEnLista(loteId, loteExplotacionId);
    l.cantHasTrabajadas = has;

    //*--- Actualizo cantidades de insumos
    if (l.insumos!.isNotEmpty)
    {
      for (var i in l.insumos!) {
        i.total = has * i.dosis!;   
      }
      paso1Controller.actualizarTotal();
    }
    paso1Controller.actualizarCosteo();
    paso1Controller.rxOLAbm.refresh();
  }

  //*----------------------------------------------------------------------------------- Recalculo
  recalcularGastosPorLote(Articulo articulo, double nuevoTotal, double anteriorTotal) async {

    //*--Recorro los lotes seleccionados para recalcular
    for (Lote lote in paso1Controller.rxOLAbm.value.lotes)
    {
      if (lote.seleccionado! && lote.insumos!.isNotEmpty)
      {
        //*-- El lote ya tiene insumos asignados, deberia buscar el insumo y si lo actualizo
        List<OLAbmInsumoLote> insumoExiste = lote.insumos!.where((i) => i.articuloId == articulo.articuloFacId).toList();
        if (insumoExiste.isNotEmpty)
        {
          insumoExiste[0].total = double.parse((nuevoTotal * insumoExiste[0].total! / anteriorTotal).toStringAsFixed(2));
          insumoExiste[0].dosis = double.parse((insumoExiste[0].total! / lote.cantHasTrabajadas!).toStringAsFixed(4));
        }
      }
    }

    //*- Actualizo total de insumos
    paso1Controller.actualizarTotalArticulo(articulo);
    paso1Controller.rxOLAbm.refresh();
  }
  

}