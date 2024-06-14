import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_controller.dart';
import 'orden_laboreo_item_paso_1_controller.dart';

class OrdenLaboreoItemPaso2Controller extends GetxController {

  OrdenLaboreoItemPaso2Controller();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  FormMode mode = FormMode.none;
  
  EAResourcesRequest paramReqEAResources = EAResourcesRequest();

  final OrdenLaboreoItemPaso1Controller paso1Controller = Get.find<OrdenLaboreoItemPaso1Controller>();
  final MenuIngenierosController recursosEAController = Get.find<MenuIngenierosController>();
  
  Rx<TextEditingController> txtOrdenLaboreoIdController = TextEditingController().obs;
  Rx<TextEditingController> txtFechaEmisionController   = TextEditingController().obs;
  Rx<TextEditingController> txtFechaVtoController       = TextEditingController().obs;
  Rx<TextEditingController> txtCotizacionController     = TextEditingController().obs;
  Rx<TextEditingController> txtPrecioHaPesos            = TextEditingController().obs;
  Rx<TextEditingController> txtPrecioHaDolar            = TextEditingController().obs;
  Rx<TextEditingController> txtObservacion               = TextEditingController().obs;
  final TextEditingController txtEstadoController       = TextEditingController();
  Rx<TextEditingController> txtTotalPesosController     = TextEditingController().obs;
  Rx<TextEditingController> txtTotalDolaresController   = TextEditingController().obs;

  Laboreo laboreoSinSeleccion = Laboreo(laboreoId: -1, laboreo: '');
  Especie especieSinSeleccion = Especie(especieId: -1, nombre: '');
  Ingeniero ingenieroSinSeleccion = Ingeniero(clienteId: -1, nombre: '');
  Contratista contratistaSinSeleccion = Contratista(clienteId: -1, nombre: '');
  ExplotacionAgropecuaria eaSinSeleccion = ExplotacionAgropecuaria(clienteId: -1, clienteNombre: '');
  UA uaSinSeleccion = UA(uaId: -1, uaNombre: '');

  Rx<bool> saving = false.obs;
  
  int pOlId = -1;
  final FocusNode txtFocusCotizacion = FocusNode();
  final FocusNode txtFocusPesos = FocusNode();
  final FocusNode txtFocusDolar = FocusNode();
  final FocusNode txtFocusObservacion = FocusNode();
   
  double oldCotizacion = 0.0;

  String accion = '';    //!-- Add Cerrar OL

  // * ----------------------------------------------------------------------------- addListerCotizacion
  void addListerCotizacion() {

    txtFocusCotizacion.addListener(() {

          if (txtCotizacionController.value.text == "")
          {
            setCotizacion(0.0);
          }
          double _newCotizacion = double.parse(txtCotizacionController.value.text);

          if (txtFocusCotizacion.hasFocus) 
          {
            //*---------------------------------------------- Entra el foco
            oldCotizacion = getCotizacion();
            if (_newCotizacion == 0.0)
            {
              setPrecioHaDolar(0.0);
              setPrecioHaPesos(0.0);
            }
            paso1Controller.rxOLAbm.refresh();
          }
          else 
          {
            if (oldCotizacion != _newCotizacion)
            {
              //*-------------------------------------------- Pierde el foco
              setCotizacion(_newCotizacion);
              double _pesos = getPrecioHaPesos();
              double _dolares = getPrecioHaDolar();
              if (_pesos != 0.0 || _dolares != 0.0 )
              {
                if (_pesos != 0.0) 
                { 
                  calcularPrecioDolar(); 
                }
                else if (_dolares != 0.0) 
                {
                  calcularPrecioPesos();
                }
              }
            }
          }
        });
  }

  // * ----------------------------------------------------------------------------- addListerPrecioEnPesos
  void addListerPrecioEnPesos() {
    txtFocusPesos.addListener(() { 
      if (!txtFocusPesos.hasFocus) 
      {
        setPrecioHA();
      }
    });
  }

  void setPrecioHA() {
    //*-------------------------------------------- Pierde el foco
    if (txtPrecioHaPesos.value.text == "")
    {
      setPrecioHaPesos(0.0);
    }
    if (txtPrecioHaPesos.value.text.isNotEmpty)
    {
      setPrecioHaPesos(double.parse(txtPrecioHaPesos.value.text));
      calcularPrecioDolar();
    }
  }

  // * ----------------------------------------------------------------------------- addListerPrecioEnPesos
  void addListerPrecioEnDolar() {
    txtFocusDolar.addListener(() { 
      //*-------------------------------------------- Pierde el foco
      if (!txtFocusDolar.hasFocus) 
      {
        if (txtPrecioHaDolar.value.text == "")
        {
          setPrecioHaDolar(0.0);
        }
        if (txtPrecioHaDolar.value.text.isNotEmpty)
        {
          setPrecioHaDolar(double.parse(txtPrecioHaDolar.value.text));
          calcularPrecioPesos();
        }
      }
    });
  }

  // * ----------------------------------------------------------------------------- addListerObservacion
  void addListerObservacion() {
    txtFocusObservacion.addListener(() { 
      //*-------------------------------------------- Pierde el foco
      if (!txtFocusObservacion.hasFocus) 
      {
        if (txtObservacion.value.text.isNotEmpty)
        {
          setObservacion(txtObservacion.value.text);
        }
      }
    });
  }

  // * ----------------------------------------------------------------------------- onClose
  @override
  void onClose() {
    txtFocusCotizacion.dispose();
    txtFocusPesos.dispose();
    txtFocusDolar.dispose();
    txtFocusObservacion.dispose();
    txtOrdenLaboreoIdController.value.dispose();
    txtFechaEmisionController.value.dispose();
    txtFechaVtoController.value.dispose();
    txtCotizacionController.value.dispose();
    txtPrecioHaPesos.value.dispose();
    txtPrecioHaDolar.value.dispose();
    txtEstadoController.dispose();
    super.onClose();
  }

  // * ----------------------------------------------------------------------------- onInit
  @override
  void onInit()  {
    super.onInit();
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    pOlId = Get.arguments["ordenLaboreoId"] as int;
    paramReqEAResources = Get.arguments["requestEARerources"] as EAResourcesRequest;
    mode = pOlId == -1 ? FormMode.insert : FormMode.update; 
    addListerCotizacion();
    addListerPrecioEnPesos();
    addListerPrecioEnDolar();
    addListerObservacion();
    accion = Get.arguments["accion"] ?? '';         //!-- Add Cerrar OL

  }

  // * ----------------------------------------------------------------------------- onReady
  @override
  void onReady() async {
    super.onReady();
    if (mode == FormMode.insert)
    { 
      //?====================================================================================
      //?-- INSERT de OL - Seteo valores por default !
      //?====================================================================================
      setCotizacion(paso1Controller.rxOLAbm.value.tipoCambio!);
      setPrecioHaPesos(paso1Controller.rxOLAbm.value.precioHaPesos!);
      setPrecioHaDolar(paso1Controller.rxOLAbm.value.precioHaDolar!);
      setObservacion(paso1Controller.rxOLAbm.value.observacion!);
    }
    else if (mode == FormMode.update)
    { 
      //?====================================================================================
      //?-- UPDATE
      //?====================================================================================
      setCotizacion(paso1Controller.rxOLAbm.value.tipoCambio!);
      setPrecioHaPesos(paso1Controller.rxOLAbm.value.precioHaPesos!);
      setPrecioHaDolar(paso1Controller.rxOLAbm.value.precioHaDolar!);
      setObservacion(paso1Controller.rxOLAbm.value.observacion!);
    }
  }

  //*-------------------------------------------------------------------- Validacion de controles
  String _errorMessage = '';
  bool isValidPaso2() {
    _errorMessage = '';

    //* Contratista
    if (paso1Controller.rxOLAbm.value.contratista == null || paso1Controller.rxOLAbm.value.contratista!.clienteId == null || paso1Controller.rxOLAbm.value.contratista!.clienteId == -1)  _errorMessage += "Falta el Contratista.\n";
    //* laboreo
    if (paso1Controller.rxOLAbm.value.laboreo == null || paso1Controller.rxOLAbm.value.laboreo!.laboreoId == null || paso1Controller.rxOLAbm.value.laboreo!.laboreoId == -1)  _errorMessage += "Falta el Laboreo.\n";
    //* cotizacion dolar
    if (paso1Controller.rxOLAbm.value.tipoCambio == null || paso1Controller.rxOLAbm.value.tipoCambio == 0.0)  _errorMessage += "Falta el Tipo de Cambio.\n";


    //? Ojo la marca en LABOREO de PermiteFacturarCero hace que el precio por ha pueda quedar en 0.0
    setPrecioHA();
    if (paso1Controller.rxOLAbm.value.laboreo != null)
    {
      bool permiteFacturarCero = paso1Controller.rxOLAbm.value.laboreo!.permiteFacturarCero!;
      if (permiteFacturarCero == false)
      {
        if (paso1Controller.rxOLAbm.value.precioHaPesos == null || paso1Controller.rxOLAbm.value.precioHaPesos == 0.0)  _errorMessage += "Falta precio \$ por ha.\n";
        if (paso1Controller.rxOLAbm.value.precioHaDolar == null || paso1Controller.rxOLAbm.value.precioHaDolar == 0.0)  _errorMessage += "Falta precio US\$ por ha.\n";
      }
    }
    
    return _errorMessage.isEmpty;
  }

  //*----------------------------------------------------------------------------------- INSERT
  void goPaso3() async {

    try {

      if (!isValidPaso2())
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
          //*- INSERT
          Get.toNamed(AppRoutes.rOlPaso3, 
            arguments: { 
              "requestEARerources": paramReqEAResources, 
              "ordenLaboreoId":     -1,
              "accion":             accion
            });
        }
        else if (mode == FormMode.update)
        {
          //*- UPDATE
          Get.toNamed(AppRoutes.rOlPaso3, 
            arguments: { 
              "requestEARerources": paramReqEAResources, 
              "ordenLaboreoId":     pOlId, 
              "accion":             accion
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


  //*----------------------------------------------------------------------------------- Contratistas
  int getContratistaId() { 
    int returnValue = 0;
    if (paso1Controller.rxOLAbm.value.contratista != null) { returnValue = paso1Controller.rxOLAbm.value.contratista!.clienteId!; }
    return returnValue;
  }
  Contratista getContratista() { 
    Contratista returnValue = contratistaSinSeleccion;
    if (paso1Controller.rxOLAbm.value.contratista != null) { returnValue = paso1Controller.rxOLAbm.value.contratista!; }
    return returnValue;
  }
  void setContratista(Contratista c) { 
    if ((paso1Controller.rxOLAbm.value.contratista == null) || 
        (paso1Controller.rxOLAbm.value.contratista != null && c.clienteId != paso1Controller.rxOLAbm.value.contratista!.clienteId))
    {
      //?-- Seteo solo si se cambio el contratista
      paso1Controller.rxOLAbm.value.contratista = c; 
      paso1Controller.rxOLAbm.refresh();
    } 
  }


  //*----------------------------------------------------------------------------------- Laboreo
  int getLaboreoId() { 
    int returnValue = 0;
    if (paso1Controller.rxOLAbm.value.laboreo != null) { returnValue = paso1Controller.rxOLAbm.value.laboreo!.laboreoId!; }
    return returnValue;
  }
  Laboreo getLaboreo() { 
    Laboreo returnValue = laboreoSinSeleccion;
    if (paso1Controller.rxOLAbm.value.laboreo != null) { returnValue = paso1Controller.rxOLAbm.value.laboreo!; }
    return returnValue;
  }
  void setLaboreo(Laboreo l) { 
    if ((paso1Controller.rxOLAbm.value.laboreo == null) || 
        (paso1Controller.rxOLAbm.value.laboreo != null && l.laboreoId != paso1Controller.rxOLAbm.value.laboreo!.laboreoId))
    {
      //?-- Seteo solo si se cambio el laboreo
      paso1Controller.rxOLAbm.value.laboreo = l; 
      paso1Controller.rxOLAbm.refresh();
    } 
  }
  
  //*----------------------------------------------------------------------------------- Cotizacion
  double getCotizacion() { 
    double returnValue = 0.0;
    if (paso1Controller.rxOLAbm.value.tipoCambio != null) { returnValue = paso1Controller.rxOLAbm.value.tipoCambio!; }
    return returnValue;
  }
  void setCotizacion(double c) { 
    txtCotizacionController.value.text = c.toString();
    paso1Controller.rxOLAbm.value.tipoCambio = c; 
    paso1Controller.actualizarCosteo();
    paso1Controller.rxOLAbm.refresh();
  }
  void clearCotizacion() {
    setCotizacion(0.0);
    //txtCotizacionController.value.selection = TextSelection.fromPosition(TextPosition(offset: txtCotizacionController.value.text.length));
  }
  
  //*----------------------------------------------------------------------------------- Precio Ha Pesos
  double getPrecioHaPesos() { 
    double returnValue = 0.0;
    if (paso1Controller.rxOLAbm.value.precioHaPesos != null) { returnValue = paso1Controller.rxOLAbm.value.precioHaPesos!; }
    return returnValue;
  }
  void setPrecioHaPesos(double pp, { bool setearFoco = false } ) { 
    txtPrecioHaPesos.value.text = pp.toString();
    paso1Controller.rxOLAbm.value.precioHaPesos = double.parse(txtPrecioHaPesos.value.text); 
    paso1Controller.actualizarCosteo();
    paso1Controller.rxOLAbm.refresh();
  }

  //*----------------------------------------------------------------------------------- Precio Ha Dolares
  double getPrecioHaDolar() { 
    double returnValue = 0.0;
    if (paso1Controller.rxOLAbm.value.precioHaDolar!= null) { returnValue = paso1Controller.rxOLAbm.value.precioHaDolar!; }
    return returnValue;
  }
  void setPrecioHaDolar(double pd) { 
    txtPrecioHaDolar.value.text = pd.toString();
    paso1Controller.rxOLAbm.value.precioHaDolar = double.parse(txtPrecioHaDolar.value.text);
    paso1Controller.actualizarCosteo(); 
    paso1Controller.rxOLAbm.refresh();
  }
 
  //*----------------------------------------------------------------------------------- observacion
  String getObservacion() { 
    String returnValue = '';
    if (paso1Controller.rxOLAbm.value.observacion != null) { returnValue = paso1Controller.rxOLAbm.value.observacion!; }
    return returnValue;
  }
  void setObservacion(String o) { 
    txtObservacion.value.text = o;
    paso1Controller.rxOLAbm.value.observacion = txtObservacion.value.text; 
    paso1Controller.rxOLAbm.refresh();
  }
 

  void calcularPrecioDolar() {
    if (getCotizacion() > 0.0)
    {
      double _pesos = getPrecioHaPesos();
      double _cotizacion = getCotizacion();
      double pd = double.parse((_pesos / _cotizacion).toStringAsFixed(3));
      setPrecioHaDolar(pd);
    }
    else {
      setPrecioHaPesos(0.0);
      setPrecioHaDolar(0.0);
    }
  }

  void calcularPrecioPesos() {
    if (getCotizacion() > 0.0)
    {
      double _dolar = getPrecioHaDolar();
      double _cotizacion = getCotizacion();
      double pp = double.parse((_dolar * _cotizacion).toStringAsFixed(2));
      setPrecioHaPesos(pp);
    }
    else {
      setPrecioHaPesos(0.0);
      setPrecioHaDolar(0.0);
    }
  }


  
}