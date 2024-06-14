import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:money2/money2.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'liquidaciones_lista_controller.dart';
import 'models/liquidaciones_model.dart';


class LiquidacionesListaPage extends GetView<LiquidacionesListaController> {
  
  LiquidacionesListaPage({Key? key}) : super(key: key);

  LiquidacionLecheItem liquidacion = LiquidacionLecheItem();
  var registro = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: const Text("Liquidaciones de Leche", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              controller.obx(
                (state) =>  RefreshIndicator(
                  color: kTLabelEspecieResumenHome,
                  backgroundColor: kTLightPrimaryColor3,
                  onRefresh: () async => await controller.obtenerLiquidacionesLeche(),
                  child: ListView.separated(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => Container(),
                    itemCount: state!.listaDeLiquidaciones.length,
                    itemBuilder: (BuildContext context, int index) {
                      //dataItem = state.listaDeNotificaciones[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        child: ExpansionTileCard(
                          baseColor: Colors.white,
                          title: ShowTitle(liquidacion: state.listaDeLiquidaciones[index]),
                          children: [
                            const SizedBox(height: 10.0),
                            ShowLiquidacionDetalle(liquidacion: state.listaDeLiquidaciones[index]),
                          ],
                        ),
                      );
                    }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Espere un momento !'),
                onEmpty: const MyDataNotFoundMessage(colorText: kTLightPrimaryColor),
                onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTRedColor),
              ),
          ]
        ));
  }
}

// * -------------------------------------------------------------------------------------------------- ShowTitle
class ShowTitle extends StatelessWidget {

  LiquidacionesListaController controller = Get.find<LiquidacionesListaController>();

  ShowTitle({
    Key? key,
    required this.liquidacion,
  }) : super(key: key);

  final LiquidacionLecheItem? liquidacion;

  @override
  Widget build(BuildContext context) {

    String nroLiq = "${liquidacion!.letra}-${liquidacion!.prefijo.toString().padLeft(4,'0')}-${liquidacion!.nro.toString().padLeft(8,'0')}";

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*--------------------------------------------------------------------- boton VER PDF del comprobante
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible:  liquidacion!.uis != '' && liquidacion!.uis != null,                            
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    child: Image.asset(Constants.kImgPDF, width: 35, height: 35),
                    onTap: () async {
                      await Get.toNamed(AppRoutes.rVerComprobante, 
                                        arguments: DownloadComprobanteRequest(
                                            tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                            gEconomicoId: controller.request.gEconomicoId,
                                            empresaId: controller.request.empresaId,
                                            guidComprobante: liquidacion!.uis,
                                            ctaCteId: null,
                                            tituloPage: "Liquidación de Leche\n$nroLiq",
                                            comprobanteAliasName: "LIQ $nroLiq",
                                          )
                                        );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat("(MMMM)    dd-MM-yyyy", "es").format(liquidacion!.fecha!).toUpperCase(), style: const TextStyle(fontSize: 12.0, color: Colors.black87)),
                    const SizedBox(height: 5.0),
                    Text(nroLiq.toString(), style: const TextStyle(fontSize: 14.0, color: Colors.black54)),
                    const Text("NRO LIQ", style: TextStyle(fontSize: 10.0, color:kTBackgroundColorBtnIngresarLogin)),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ],
          ),
          Text( Money.fromNumWithCurrency(liquidacion!.neto!, Constants.monedaAR).toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.green)),
          const Text("NETO LIQUIDADO", style: TextStyle(fontSize: 10.0, color:kTBackgroundColorBtnIngresarLogin)),
        ],
      ),
    );
  }
}

// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowLiquidacionDetalle extends StatelessWidget {

  final LiquidacionLecheItem liquidacion;

  const ShowLiquidacionDetalle({
    Key? key,
    required this.liquidacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {   
    return Column(
      children: [
        //*------------ Mercado Interno
        Visibility(
          visible: liquidacion.listaMercadoInterno.isNotEmpty,
          child: ShowMercadoInterno(lista: liquidacion.listaMercadoInterno
        )),
        //*------------ Bnificacion Calidad
        Visibility(
          visible: liquidacion.listaBonificacionesCalidad.isNotEmpty,
          child: ShowBonificacionCalidad(lista: liquidacion.listaBonificacionesCalidad
        )),
        //*------------ Bnificacion Comerciales
        Visibility(
          visible: liquidacion.listaBonificacionesCalidad.isNotEmpty,
          child: ShowBonificacionesComerciales(lista: liquidacion.listaBonificacionesComerciales
        ))
      ],
    );
  }
}

//*-------------------------------------------------------------- ShowMercadoInterno
class ShowMercadoInterno extends StatelessWidget {

  final Color _color = const Color.fromARGB(255, 141, 200, 255);
  final Color _colorb = const Color.fromARGB(255, 229, 242, 255);

  final List<LiquidacionLecheMercadoInterno> lista;

  const ShowMercadoInterno({
    Key? key,
    required this.lista
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: const  BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
              color: _color),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('MERCADO  INTERNO', style: TextStyle(fontSize: 14.0, color: Colors.black45, fontWeight: FontWeight.bold)),
            )
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Container(),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: (index % 2 == 0) ? Colors.white70 : _colorb,
                  border: Border(left: BorderSide( 
                    color: _color,
                    width: 5.0,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lista[index].concepto.toUpperCase(), style: const TextStyle(fontSize: 12.0, color: kTAllLabelsColor)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('${lista[index].cantidadKg.toStringAsFixed(2)}  Kg', style: const TextStyle(fontSize: 13.0))),
                          Expanded(child: Text(Money.fromNumWithCurrency(lista[index].precioKg, Constants.monedaAR).toString(), style: const TextStyle(fontSize: 13.0, color: kTLabelTextBoxLogin, fontWeight: FontWeight.bold))),
                          Expanded(child: Text(Money.fromNumWithCurrency(lista[index].importe, Constants.monedaAR).toString(), textAlign: TextAlign.end, style: const TextStyle(fontSize: 13.0, color: Colors.green, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      
    );
  }
}


//*-------------------------------------------------------------- ShowMercadoBonificacionCalidad
class ShowBonificacionCalidad extends StatelessWidget {

  final Color _color = const Color.fromARGB(255, 253, 202, 125);
  final Color _colorb = const Color.fromARGB(255, 255, 245, 230);

  final List<LiquidacionLecheBonificacionCalidad> lista;

  const ShowBonificacionCalidad({
    Key? key,
    required this.lista
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: const  BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
              color: _color),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('BONIFICACION  CALIDAD', style: TextStyle(fontSize: 14.0, color: Colors.black45, fontWeight: FontWeight.bold)),
            )
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Container(),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: (index % 2 == 0) ? Colors.white70 : _colorb,
                  border: Border(left: BorderSide( 
                    color: _color,
                    width: 5.0,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lista[index].concepto.toUpperCase(), style: const TextStyle(fontSize: 12.0, color: kTAllLabelsColor)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text(lista[index].cantidadTexto.trim(), textAlign: TextAlign.start, style: TextStyle(fontSize: 13.0, 
                            color: lista[index].cantidadTexto.trim().toUpperCase() == 'LIBRE'
                                    ? Colors.green
                                    : lista[index].cantidadTexto.trim().toUpperCase() == 'NO LIBRE'
                                      ? Colors.red
                                      : lista[index].cantidadTexto.trim().toUpperCase() == 'EN SANEAMIENTO'
                                        ? Colors.orangeAccent
                                        : kTAllLabelsColor
                            ))),
                          Expanded(child: Text('${lista[index].porcentaje.toStringAsFixed(2)}  %', style: const TextStyle(fontSize: 13.0))),
                          Expanded(child: Text(Money.fromNumWithCurrency(lista[index].importe, Constants.monedaAR).toString(), textAlign: TextAlign.end, style: const TextStyle(fontSize: 13.0, color: Colors.green, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      
    );
  }
}


//*-------------------------------------------------------------- ShowBonificacionesComerciales
class ShowBonificacionesComerciales extends StatelessWidget {

  final Color _color = const Color.fromARGB(255, 255, 201, 248);
  final Color _colorb = const Color.fromARGB(255, 255, 246, 254);

  final List<LiquidacionLecheBonificacionComerciales> lista;

  const ShowBonificacionesComerciales({
    Key? key,
    required this.lista
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: const  BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
              color: _color),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('BONIFICACIONES  COMERCIALES', style: TextStyle(fontSize: 14.0, color: Colors.black45, fontWeight: FontWeight.bold)),
            )
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Container(),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: (index % 2 == 0) ? Colors.white70 : _colorb,
                  border: Border(left: BorderSide( 
                    color: _color,
                    width: 5.0,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lista[index].concepto.toUpperCase(), style: const TextStyle(fontSize: 12.0, color: kTAllLabelsColor)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('${lista[index].porcentaje} %', style: const TextStyle(fontSize: 13.0))),
                          Expanded(child: Text(Money.fromNumWithCurrency(lista[index].importe, Constants.monedaAR).toString(), textAlign: TextAlign.end, style: const TextStyle(fontSize: 13.0, color: Colors.green, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      
    );
  }
}