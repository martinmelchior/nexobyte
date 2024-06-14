import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:money2/money2.dart';
import '../models/remitos_sin_factura_model.dart';
import 'remitos_sin_factura_lista_controller.dart';

// ignore: must_be_immutable
class RemitosSinFacturaListaPage extends GetView<RemitosSinFacturaListaController> {
  
  RemitosSinFacturaListaPage({Key? key}) : super(key: key);

  DetallePorArticulo? detallePorArticulo;

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
           title:  Column(
              children: [
                Text(controller.itemResumenCtaCte.cliente, style: const TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
                const Text("Artículos Pendientes de Facturar", style: TextStyle(fontSize: 13.0, color: kTAllLabelsColor)),
              ],
            ),
          centerTitle: true,
        ),       
        body: Stack(children: [
          kTBackgroundContainer,
          controller.obx(
            (state) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('SALDO', style: TextStyle(color: kTAllLabelsColor)),
                      Text(Money.fromNumWithCurrency(state!.saldo, Constants.monedaUSD).toString(), 
                        style: TextStyle(fontSize: 20.0, color: state.saldo > 0 ? Colors.red : Colors.green)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listaDetallePorArticulo.length,
                      itemBuilder: (BuildContext context, int index) {
                        detallePorArticulo = state.listaDetallePorArticulo[index];
                        return Column(
                          children: [
                            ShowArticulo(detallePorArticulo: detallePorArticulo!),
                          ],
                        );
                      }),
                ),
              ],
            ),
            onLoading: const MyProgressIndicactor(
                mensaje: 'Aguarde un momento ...'),
            onEmpty: const MyDataNotFoundMessage(mensaje: 'Parece que no tienes Artículos pendientes de Remitar !'),
            onError: (error) => MyCustomErrorMessage(error: error.toString()),
          ),
        ]));
  }
}

// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowArticulo extends StatelessWidget {
  
  final DetallePorArticulo detallePorArticulo;

  const ShowArticulo({
    Key? key,
    required this.detallePorArticulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white60),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(detallePorArticulo.articulo.trim().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)
                      )
                  ),
                  Expanded(child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,    
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Text(
                          Money.fromNumWithCurrency(detallePorArticulo.subTotal, Constants.monedaUSD).toString(),
                          textAlign: TextAlign.right, 
                          style: TextStyle(fontSize: 16.0, 
                            color: detallePorArticulo.subTotal > 0 ? Colors.red : Colors.green))),
                      ],
                    )),                                    
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
