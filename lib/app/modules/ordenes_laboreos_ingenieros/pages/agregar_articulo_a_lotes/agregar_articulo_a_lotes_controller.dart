
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/articulos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_1_controller.dart';


class AgregarArticuloALotesController extends GetxController {
  
  AgregarArticuloALotesController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final OrdenLaboreoItemPaso1Controller paso1Controller = Get.find<OrdenLaboreoItemPaso1Controller>();
  
  late Rx<Articulo> articulo = Articulo().obs;

  final FocusNode txtFocusDosis = FocusNode();
  final FocusNode txtFocusTotal = FocusNode();
  Rx<TextEditingController> txtDosisController = TextEditingController().obs;
  Rx<TextEditingController> txtTotalController = TextEditingController().obs;
  bool addInsumoAUnLote = false;

  double hasTotalesShow = 0;

  //* ------------------------------------------------------------------------------- onInit
  @override
  void onInit() {
    addInsumoAUnLote = Get.arguments["addInsumoAUnLote"] as bool;
    articulo.value = Get.arguments["articulo"] as Articulo;
    txtTotalController.value.text = "0.0";

    for (Lote lote in paso1Controller.rxOLAbm.value.lotes) 
    {
      if (lote.seleccionado!)
      {
        hasTotalesShow += lote.cantHasTrabajadas!;
      }
    }

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

  //*-------------------------------------------------------------------- Agregar INSUMO a TODOS LOS LOTES SELECCIONADOS
  agregarInsumo() {

    paso1Controller.rxOLAbm.refresh();

    bool isAdded = false;

    //*-- Me paro sobre cada Lote y busco el artículo a ver si ya está
    for (Lote lote in paso1Controller.rxOLAbm.value.lotes)
    {
      if (lote.seleccionado!)
      {
        if (lote.insumos!.isEmpty)
        {
          //*-- Si no hay insumos aún, lo agrego sin buscar y eliminar previamente antes
          OLAbmInsumoLote addInsumo = addInsumoNuevo(lote.cantHasTrabajadas ?? 0.0);
          //lote.insumos!.add(addInsumo);
          lote.insumos = [...lote.insumos!, addInsumo];
          isAdded = true;
        }
        else
        {
          //*-- El lote ya tiene insumos asignados, deberia buscar el insumo y si lo encuentro lo ELIMINO y lo AGREGO NUEVAMENTE
          List<OLAbmInsumoLote> insumoExiste = lote.insumos!.where((i) => i.articuloId == articulo.value.articuloFacId).toList();
          if (insumoExiste.isEmpty)
          {
            //*-- No encuentro el insumo en la lista lo agrego
            OLAbmInsumoLote addInsumo = addInsumoNuevo(lote.cantHasTrabajadas ?? 0.0);
            //lote.insumos!.add(addInsumo);
            lote.insumos = [...lote.insumos!, addInsumo];
            isAdded = true;
          }
          else 
          {
            //*-- Lo elimino para luego agregarlo
            lote.insumos!.removeWhere((i) => i.articuloId == articulo.value.articuloFacId);
            //*-- No encuentro el insumo en la lista lo agrego
            OLAbmInsumoLote addInsumo = addInsumoNuevo(lote.cantHasTrabajadas ?? 0.0);
            //lote.insumos!.add(addInsumo);
            lote.insumos = [...lote.insumos!, addInsumo];
            isAdded = true;
          }
        }
      }
    }

    //*- Actualizo total de insumos
    paso1Controller.actualizarTotalArticulo(articulo.value);

  }

  OLAbmInsumoLote addInsumoNuevo(double _cantHasTrabajadasLote) {
    return OLAbmInsumoLote(
              olLoteInsumoId: -1,                           //*--- -1 porque es una alta      
              articuloId: articulo.value.articuloFacId, 
              nombre: articulo.value.nombre,
              dosis: double.parse(txtDosisController.value.text), 
              idUnico: articulo.value.idUnico,                                  
              //total: double.parse(txtDosisController.value.text) * _cantHasTrabajadas, 
              total: (_cantHasTrabajadasLote * double.parse(txtTotalController.value.text)) / hasTotalesShow, 
              precioUltimaCompra: articulo.value.preBase, 
              precioPromedioPonderado: articulo.value.ppp, 
              precioUltimaCompraCotizacion: articulo.value.pbCotizacion, 
              precioPromedioPonderadoCotizacion: articulo.value.pppCotizacion,
              umOrigen: articulo.value.umOrigen,
              unidadId: articulo.value.unidadId);
  }

}