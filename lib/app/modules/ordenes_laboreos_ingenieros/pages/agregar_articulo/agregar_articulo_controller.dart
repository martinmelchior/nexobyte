
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/articulos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_1_controller.dart';


class AgregarArticuloController extends GetxController {
  
  AgregarArticuloController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final OrdenLaboreoItemPaso1Controller paso1Controller = Get.find<OrdenLaboreoItemPaso1Controller>();
  
  late Rx<Lote> lote = Lote().obs;
  late Rx<Articulo> articulo = Articulo().obs;

  final FocusNode txtFocusDosis = FocusNode();
  final FocusNode txtFocusTotal = FocusNode();
  Rx<TextEditingController> txtDosisController = TextEditingController().obs;
  Rx<TextEditingController> txtTotalController = TextEditingController().obs;
  bool addInsumoAUnLote = false;  

  //* ------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    lote.value = Get.arguments["lote"] as Lote;
    articulo.value = Get.arguments["articulo"] as Articulo;
    super.onInit();
  } 


  //*-------------------------------------------------------------------- Validacion de controles
  String errorMessage = '';
  bool pageIsValid() {
  
    //-- Limpio Errores
    errorMessage = '';

    try {
      if (txtDosisController.value.text == '' || double.parse(txtDosisController.value.text) == 0.0) 
      {
        errorMessage = "Falta cargar la dosis a aplicar!";
      }
      if (double.parse(txtTotalController.value.text) > articulo.value.stockDisponible) 
      {
        errorMessage = "El Stock disponible no es suficiente para las cantidades que quiere aplicar!";
      }
    } catch (e) {
        errorMessage = "Parece que ocurrió un error!";
    }
    return errorMessage.isEmpty;
  }

  //*-------------------------------------------------------------------- Agregar INSUMO
  agregarInsumo() {
    
      //*-- Me paro sobre el Lote seleccionado
      //-- Fix Lote Explotacion
      List<Lote> listaLotes = paso1Controller.rxOLAbm.value.lotes.where((l) => l.loteId == lote.value.loteId && l.explotacionLoteId == lote.value.explotacionLoteId).toList();
      if (listaLotes.length == 1)
      {
        Lote lote = listaLotes[0];
        if (lote.insumos!.isEmpty)
        {
          //*-- Si no hay insumos aún lo agrego sin buscar y eliminar previamente antes
          OLAbmInsumoLote addInsumo = addInsumoNuevo();
          //lote.insumos!.add(addInsumo);
          lote.insumos = [...lote.insumos!, addInsumo];
        }
        else
        {
          //*-- El lote ya tiene insumos asignados, deberia buscar el insumo y si lo encuentro lo ELIMINO y lo AGREGO NUEVAMENTE
          List<OLAbmInsumoLote> insumoExiste = lote.insumos!.where((i) => i.articuloId == articulo.value.articuloFacId).toList();
          if (insumoExiste.isEmpty)
          {
            //*-- No encuentro el insumo en la lista lo agrego
            OLAbmInsumoLote addInsumo = addInsumoNuevo();
            //lote.insumos!.add(addInsumo);
            lote.insumos = [...lote.insumos!, addInsumo];
          }
          else 
          {
            //*-- Lo elimino para luego agregarlo
            lote.insumos!.removeWhere((i) => i.articuloId == articulo.value.articuloFacId);
            //*-- No encuentro el insumo en la lista lo agrego
            OLAbmInsumoLote addInsumo = addInsumoNuevo();
            //lote.insumos!.add(addInsumo);
            lote.insumos = [...lote.insumos!, addInsumo];
          }
        }

        //*- Actualizo total de insumos
        paso1Controller.actualizarTotalArticulo(articulo.value);

    }
  }

  OLAbmInsumoLote addInsumoNuevo() {
    return OLAbmInsumoLote(
              olLoteInsumoId: -1,                           //*--- -1 porque es una alta      
              articuloId: articulo.value.articuloFacId, 
              nombre: articulo.value.nombre,
              dosis: double.parse(txtDosisController.value.text), 
              idUnico: articulo.value.idUnico,
              total: double.parse(txtTotalController.value.text), 
              precioUltimaCompra: articulo.value.preBase, 
              precioPromedioPonderado: articulo.value.ppp, 
              precioUltimaCompraCotizacion: articulo.value.pbCotizacion, 
              precioPromedioPonderadoCotizacion: articulo.value.pppCotizacion,
              umOrigen: articulo.value.umOrigen,
              unidadId: articulo.value.unidadId,
            );
  }

}