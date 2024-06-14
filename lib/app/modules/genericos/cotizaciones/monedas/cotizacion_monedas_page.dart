import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/model/model_cotizaciones.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:money2/money2.dart';
import 'cotizacion_monedas_controller.dart';

class CotizacionMonedaWidget extends GetView<CotizacionMonedaController> {

  final List<CotizacionMoneda> listaCotizacionMoneda;
  final List<CotizacionMoneda> _listaToShow = <CotizacionMoneda>[];

  CotizacionMonedaWidget(this.listaCotizacionMoneda, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _listaToShow.assignAll(listaCotizacionMoneda.where((element) => element.descripcion.toUpperCase().startsWith('DOLAR BNA')).toList());

    return  Container(
        width: double.infinity,
        color: Colors.white.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
                itemCount: _listaToShow.length,
                itemBuilder: (BuildContext context, int index) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_listaToShow[index].descripcion, style: const TextStyle(color: kTLabelDolar, fontSize: 12)),
                            Text(Money.fromNumWithCurrency(_listaToShow[index].compra, Constants.monedaAR).toString(), style: const TextStyle(color: kTLabelDolarCotizacion, fontSize: 12, fontWeight: FontWeight.bold)),
                            Text("Vta " + Money.fromNumWithCurrency(_listaToShow[index].venta, Constants.monedaAR).toString(), style: const TextStyle(color: kTLabelDolarCotizacion, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                      );
                    }),
      ),
    );
  }

}