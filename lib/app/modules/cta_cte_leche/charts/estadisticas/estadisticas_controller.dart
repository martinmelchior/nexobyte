import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/model/leche.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'estadisticas_provider.dart';

class EstadisticasController extends GetxController with StateMixin<ObtenerMOResponse> {

  EstadisticasController();

  final EstadisticasProvider _provider = Get.find<EstadisticasProvider>();

  late TrackballBehavior trackballBehavior;
  late TooltipBehavior tooltipBehavior;
  late CtaCteLecheResumenDeLitrosMesItem parameter;
  late DetalleEntregasLecheRequest _detalleEntregaLeche;
  
  late double minimoB = 1;
  late double maximoB = 4;
  late double minimoP = 1;
  late double maximoP = 4;
  late double minimoUFC = 0;
  late double maximoUFC = 100;
  late double minimoRCS = 0;
  late double maximoRCS = 100;
  late double minimoT = 0;
  late double maximoT = 20;

  Rx<String> titulo = 'Grasa Butirosa'.obs;
  
  List<ChartDataButirosa> listaButirosa = [];
  List<ChartDataProteinas> listaProteinas = [];
  List<ChartDataUFC> listaUFC = [];
  List<ChartDataRCS> listaRCS = [];
  List<ChartDataTemperatura> listaTemp = [];

  @override
  void onInit() {
    // * ----------------------------------------------------------------------------- en onInit ya recibo los parametros !
    parameter = Get.arguments as CtaCteLecheResumenDeLitrosMesItem;

    // * ----------------------------------------------------------------------------- Cargo detalle entrega leche request
    _detalleEntregaLeche = DetalleEntregasLecheRequest(
      clienteId: parameter.clienteId,
      clienteTamboId: parameter.tamboId,
      empresaId: parameter.empresaId,
      tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
      fechaConsulta: DateTime(2022),
      top: 35);
    
    trackballBehavior = TrackballBehavior(
                  enable: true,
                  tooltipAlignment: ChartAlignment.near,
                  tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
                  activationMode: ActivationMode.singleTap
                );
    tooltipBehavior = TooltipBehavior(enable: true);
    super.onInit();
  }

  @override
  void onReady() {
    obtenerMO();
    EstadisticasDeUso.send("Estadísticas del Tambo");
    super.onReady();
  }

  // * ----------------------------------------------------------------------------------------------------------- obtenerDetalleDeCC
  Future<void> obtenerMO() async {

    initializeDateFormatting();
    ObtenerMOResponse _response = ObtenerMOResponse(); 

    try {

      ObtenerMORequest request = ObtenerMORequest(
        empresaId: parameter.empresaId,
        clienteId: parameter.clienteId,
        clienteTamboId: parameter.tamboId,
        fechaConsulta: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
        top: 60
      );

      change(null, status: RxStatus.loading());

      final DateFormat formatter = DateFormat('dd MMM yy', 'es');

      //*---- Aca traigo las entregas de leche (temperatura top 60)
      DetalleEntregasLecheResponse _entregasLeche = await _provider.obtenerTopEntregasDeLeche(_detalleEntregaLeche);
      if (_entregasLeche.listaEntregasLeche.isNotEmpty)
      {
        //*------------------------------------------ Recorro la lista para armar valores para el grafico
        for (var e in _entregasLeche.listaEntregasLeche) {
          listaTemp.add(ChartDataTemperatura(e.custom, e.temperatura, e.temperaturaRef, Tambos.getColorAlertasByLetra(e.temperaturaAlerta))); 
        }

        //*-------------------------------------------------------------------------------------- MAXIMOS / MINIMOS TEMPERATURA
        ChartDataTemperatura _maxT = listaTemp.reduce((a,b) => a.temp > b.temp ? a : b );
        maximoT = _maxT.temp + 2;
      }


      //*---- Aca trailgo las MO
      _response = await _provider.obtenerMO(request);
      if (_response.listaMO.isNotEmpty)
      {
        //*------------------------------------------ Existen muestras oficiales entonces preparo
        for (var e in _response.listaMO) {
          String _fe = formatter.format(e.fecha).toString();
          listaButirosa.add(ChartDataButirosa(_fe.toUpperCase(), e.grasaButirosa, e.grasaButirosaMin, e.grasaButirosaRef, Tambos.getColorAlertasByLetra(e.grasaButirosaAlerta))); 
          listaProteinas.add(ChartDataProteinas(_fe.toUpperCase(), e.proteinas, e.proteinasMin, e.proteinasRef, Tambos.getColorAlertasByLetra(e.proteinasAlerta))); 
          listaUFC.add(ChartDataUFC(_fe.toUpperCase(), e.ufc, e.ufcMin, e.ufcRef, Tambos.getColorAlertasByLetra(e.ufcAlerta))); 
          listaRCS.add(ChartDataRCS(_fe.toUpperCase(), e.rcs, e.rcsMin, e.rcsRef, Tambos.getColorAlertasByLetra(e.rcsAlerta))); 
        }

        //*-------------------------------------------------------------------------------------- BUTIROSA
        ChartDataButirosa _minB = listaButirosa.reduce((a,b) => a.y < b.y ? a : b );
        minimoB = _minB.y - 0.2;
        if (minimoB >= _response.listaMO[0].grasaButirosaMin)
        {
          minimoB = _response.listaMO[0].grasaButirosaMin - 0.2;
        }
        ChartDataButirosa _maxB = listaButirosa.reduce((a,b) => a.y > b.y ? a : b );
        maximoB = _maxB.y + 0.3;

        //*-------------------------------------------------------------------------------------- PROTEINAS
        ChartDataProteinas _minP = listaProteinas.reduce((a,b) => a.y < b.y ? a : b );
        minimoP = _minP.y - 0.2;
        if (minimoP >= _response.listaMO[0].grasaButirosaMin)
        {
          minimoP = _response.listaMO[0].grasaButirosaMin - 0.2;
        }
        ChartDataProteinas _maxP = listaProteinas.reduce((a,b) => a.y > b.y ? a : b );
        maximoP = _maxP.y + 0.3;

        //*-------------------------------------------------------------------------------------- UFC
        ChartDataUFC _minUFC = listaUFC.reduce((a,b) => a.y < b.y ? a : b );
        minimoUFC = _minUFC.y - 10;
        if (minimoUFC < 0)
        {
          minimoUFC = 0;
        }
        ChartDataUFC _maxUFC = listaUFC.reduce((a,b) => a.y > b.y ? a : b );
        if (_maxUFC.y > _maxUFC.ref)
        {
          maximoUFC = _maxUFC.y + 30;
        }
        else
        {
          maximoUFC = _maxUFC.ref + 30;
        }
        
        //*-------------------------------------------------------------------------------------- RCS
        ChartDataRCS _minRCS = listaRCS.reduce((a,b) => a.y < b.y ? a : b );
        minimoRCS = _minRCS.y - 10;
        if (minimoRCS < 0)
        {
          minimoRCS = 0;
        }
        ChartDataRCS _maxRCS = listaRCS.reduce((a,b) => a.y > b.y ? a : b );
        if (_maxRCS.y > _maxRCS.ref)
        {
          maximoRCS = _maxRCS.y + 30;
        }
        else
        {
          maximoRCS = _maxRCS.ref + 30;
        }

        change(_response, status: RxStatus.success());
      }
      else
      {
        change(null, status: RxStatus.empty());
      }
    } 
    catch(e) {
      String error = ApiExceptions.getCustomError(e);
      change(null, status: RxStatus.error(error));
    }
  }
  
}

class ChartDataButirosa {
  ChartDataButirosa(this.x, this.y, this.min, this.ref, this.color);
  final String x;
  final double y;
  final double min;
  final double ref;
  final Color color;
}

class ChartDataProteinas {
  ChartDataProteinas(this.x, this.y, this.min, this.ref, this.color);
  final String x;
  final double y;
  final double min;
  final double ref;
  final Color color;
}

class ChartDataUFC {
  ChartDataUFC(this.x, this.y, this.min, this.ref, this.color);
  final String x;
  final double y;
  final double min;
  final double ref;
  final Color color;
}

class ChartDataRCS {
  ChartDataRCS(this.x, this.y, this.min, this.ref, this.color);
  final String x;
  final double y;
  final double min;
  final double ref;
  final Color color;
}

class ChartDataTemperatura {
  ChartDataTemperatura(this.custom, this.temp, this.ref, this.color);
  final String custom;
  final double temp;
  final double ref;
  final Color color;
}