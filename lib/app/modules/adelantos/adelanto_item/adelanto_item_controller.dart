
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cta_cte_resumen_saldo.dart';
import 'adelanto_item_provider.dart';


class AdelantoItemController extends GetxController with GetSingleTickerProviderStateMixin {

  AdelantoItemController();


  SOCtaCteOrigen ccSinSeleccion = SOCtaCteOrigen(clienteId: -1, cliente: '', nroCtaCte: -1, empresa: '', empresaId: '', gEconomicoId: '');

  final AdelantoItemProvider _provider = Get.find<AdelantoItemProvider>();
  
  late Animation<double> animation;
  late AnimationController animationController;
  final TextEditingController txtFechaController      = TextEditingController();
  final TextEditingController txtCantidadController   = TextEditingController();
  final TextEditingController txtCtaOrigenController  = TextEditingController();
  final TextEditingController txtObservacionController= TextEditingController();
  
  late Solicitud solicitud;
  late CtaCteResumenDeSaldosItem itemResumenCtaCte;
  FormMode mode = FormMode.none;
  late GenericoRequest gec;

  //*------------------------------------------------------------------------------------- OBSERVABLES
  Rx<Solicitud> rxSolicitudItem = Solicitud().obs;

  Rx<bool> isPendiente = false.obs;

  //*----------------------------------------------------------------------------------- Refresca total efectivo
  void refrescarTotalEfectivo() {
    double totalEfectivo = 0.0;
    for (SOEfectivo e in rxSolicitudItem.value.listaDeEfectivo) {
      totalEfectivo += e.importe ?? 0.0;
    }
    rxSolicitudItem.value.totalEfectivo = totalEfectivo;
  }
  //*----------------------------------------------------------------------------------- Refresca total cheque
  void refrescarTotalCheque() {
    double totalCheque = 0.0;
    for (SOCheque e in rxSolicitudItem.value.listaDeCheques) {
      totalCheque += e.importe ?? 0.0;
    }
    rxSolicitudItem.value.totalCheques = totalCheque;
  }
  //*----------------------------------------------------------------------------------- Refresca transferencias propias
  void refrescarTotalTransferenciasPropias() {
    double total = 0.0;
    for (SOTransferencia e in rxSolicitudItem.value.listaDeTransferenciasPropias) {
      total += e.importe ?? 0.0;
    }
    rxSolicitudItem.value.totalTransferenciasPropias = total;
  }
  //*----------------------------------------------------------------------------------- Refresca transferencias otras cuentas
  void refrescarTotalTransferenciasOtrasCuentas() {
    double total = 0.0;
    for (SOTransferencia e in rxSolicitudItem.value.listaDeTransferenciasOtras) {
      total += e.importe ?? 0.0;
    }
    rxSolicitudItem.value.totalTransferenciasOtras = total;
  }

  //*----------------------------------------------------------------------------------- INIT
  @override
  void onInit()  {
    //!---- Obtengo parametros de entrada: Si viene -1 es una ALTA
    var pSolicitudId = Get.arguments["solicitudId"] as int;
    itemResumenCtaCte = Get.arguments["itemResumenCtaCte"] as CtaCteResumenDeSaldosItem;
    mode = pSolicitudId == -1 ? FormMode.insert : FormMode.update; 

    gec = GenericoRequest(
            tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
            gEconomicoId: itemResumenCtaCte.gEconomicoId,
            empresaId: itemResumenCtaCte.empresaId,
            clienteId: itemResumenCtaCte.clienteId,
            solicitudId: pSolicitudId,
          );

    
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  
    super.onInit();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  //*----------------------------------------------------------------------------------- READY
  @override
  void onReady() async {
    animationController.forward();
    if (mode == FormMode.insert)
    {
      isPendiente.value = true;
      
      //?--------------------------------------------------------- INSERT
      rxSolicitudItem.value.solicitudId = -1;
      rxSolicitudItem.value.clienteId = itemResumenCtaCte.clienteId;
      rxSolicitudItem.value.cliente = txtCtaOrigenController.text = itemResumenCtaCte.cliente;
      rxSolicitudItem.value.empresaId = itemResumenCtaCte.empresaId;
      rxSolicitudItem.value.empresa = itemResumenCtaCte.empresa;
      rxSolicitudItem.value.gEconomicoId = itemResumenCtaCte.gEconomicoId;
      rxSolicitudItem.value.estado = "PENDIENTE";
      rxSolicitudItem.value.fechaCarga = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    else if (mode == FormMode.update)
    {
      //?--------------------------------------------------------- UPDATE
      try {
        Get.dialog(const Center(child: kTCpi), barrierDismissible: false);

        ObtenerSolicitudesResponse _response = ObtenerSolicitudesResponse();
        _response = await _provider.obtenerSolicitudes(gec);
        Get.back();
        
        if (_response.listaDeSolicitudes.isNotEmpty)
        {
          Solicitud s = _response.listaDeSolicitudes[0];
          rxSolicitudItem.value = s;
          rxSolicitudItem.refresh();
          txtObservacionController.text = s.observacion!;

          isPendiente.value = (rxSolicitudItem.value.estado == "PENDIENTE");
        }
      }
      catch (e)
      {
        Get.back();
      }
    }
    isPendiente.refresh();
    super.onReady();
  }

  //*----------------------------------------------------------------------------------- obtenerCtasCtesOrigen
  Future<List<SOCtaCteOrigen>> obtenerCtasCtesOrigen() async {
    List<SOCtaCteOrigen> listaResult = [];
    try {
      ObtenerCtasCtesOrigenResponse response = await _provider.obtenerCtasCtesOrigen();
      return response.listaDeCtasCtesOrigen;
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return listaResult;
  }



  //*----------------------------------------------------------------------------------- Enviar Solicitud
  Future<bool> enviarSolicitud() async {
    bool result = false;
    try {
      return await _provider.enviarSolicitud(rxSolicitudItem.value, gec);
    }
    catch(e) {
      ApiExceptions.procesarError(e);
    }
    return result;
  }

  //*----------------------------------------------------------------------------------- cuentas corrientes origen
  int getCtaCteOrigenId() { 
    int returnValue = 0;
    if (rxSolicitudItem.value.clienteId != null) { returnValue = rxSolicitudItem.value.clienteId!; }
    return returnValue;
  }
  SOCtaCteOrigen getCtaCteOrigen() { 
    SOCtaCteOrigen returnValue = ccSinSeleccion;
    if (rxSolicitudItem.value.clienteId != null) 
    { 
      returnValue = SOCtaCteOrigen(
        clienteId: rxSolicitudItem.value.clienteId!,  
        cliente: rxSolicitudItem.value.cliente!,
        nroCtaCte: rxSolicitudItem.value.nroCtaCte!,
        empresa: rxSolicitudItem.value.empresa!,
      ); 
    }
    return returnValue;
  }
  void setCtaCteOrigen(SOCtaCteOrigen cc, bool refreshCombos) { 
    if (rxSolicitudItem.value.clienteId == null || cc.clienteId != rxSolicitudItem.value.clienteId)
    {
      rxSolicitudItem.value.clienteId = cc.clienteId;  
      rxSolicitudItem.value.cliente = cc.cliente;
      rxSolicitudItem.value.nroCtaCte = cc.nroCtaCte;
      rxSolicitudItem.refresh();
    } 
  }


  showAlertDialog(BuildContext context) {

    return Get.dialog(AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('ATENCION', style: TextStyle(color: kTRedColor, fontSize: 13.0),),
      titleTextStyle: const TextStyle(fontSize: 16.0, color: Colors.orange),
      content: const Text('Seguro que envías tu Solicitud de Adelantos a Administración ?', style: TextStyle(fontSize: 14.0, color: Colors.black)),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  child: const Text("AUN NO"),
                  onPressed: () {
                    Get.back(result: false);
                  }),
              TextButton(
                  child: const Text("SI"),
                  onPressed: () async {
                    Get.back(result: true);
                  }),
            ],
          ),
        ),
      ],
    ));

  }
}