import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/utils.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:money2/money2.dart';
import 'ordenes_laboreo_ingeniero_detalle_controller.dart';

// ignore: must_be_immutable
class OrdenLaboreoDetalleIngenieroPage
    extends GetView<OrdenLaboreoDetalleIngenieroController> {
      
  OrdenLaboreoDetalleIngenieroPage({Key? key}) : super(key: key);

  OLFullIngeniero? olFullIngeniero;

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    textStyle: const TextStyle(fontSize: 13.0, fontFamily: "OpenSans"),
    foregroundColor: kTLightPrimaryColor2,
    shadowColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBar(
              bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 5.0,
                tabs: [
                  Tab(
                      child: Text('DATOS\nPRINCIPALES',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor))),
                  Tab(
                      child: Text('TOTAL\nINSUMOS',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor))),
                  Tab(
                      child: Text('INSUMOS\nPOR LOTES',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor))),
                ],
              ),
              flexibleSpace: kTflexibleSpace,
              elevation: 10.0,
              backgroundColor: kTLightPrimaryColor,
              iconTheme: const IconThemeData(
                color: kTIconColor, //change your color here
              ),
              title: const Text("Orden de Laboreo",
                  style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
              centerTitle: true,
            ),
            body: controller.obx(
              (state) => TabBarView(
                children: [
                  //!------------------------------------------- tab 1
                  CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _datosPrincipales(
                                  state!,
                                  controller.param.gEconomicoId,
                                  controller.param.empresaId),
                            )),
                            //-- Add Remitar OL
                            Obx(() => Visibility(
                                  visible: controller.isRemitar.value,
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kTBackgroundColorBtnIngresarLogin),
                                        elevation: MaterialStateProperty.all(15.0),
                                        padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)))),
                                        onPressed: () => Get.toNamed(AppRoutes.rOlRemitarIngeniero, arguments: { 'ordenLaboreo': controller.param, 'recursosEA': controller.recursosEA }),
                                        child: SizedBox(
                                          width: Get.width * 0.85,
                                          child: const Text('Remitar OL',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kTLabelColorBtnIngresarLogin,
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              )
                                            ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0)
                                    ],
                                  )
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //!------------------------------------------- tab 2
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _totalInsumos(state),
                    ),
                  ),
                  //!------------------------------------------- tab 3
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: _totalInsumosPorLotes(state),
                  ),
                ],
              ),
              onLoading: const MyProgressIndicactor(
                  mensaje: 'Buscando Orden de Laboreo !'),
              onEmpty: const MyDataNotFoundMessage(),
              onError: (error) => MyCustomErrorMessage(error: error.toString()),
            )));
  }
}

Widget _getPrecios(OLFullIngeniero ordenLaboreo) {
  double hasTrabajadas = 0;
  for (var lote in ordenLaboreo.listaDetalleLotes) {
    hasTrabajadas += lote.cantHasParciales;
  }

  Widget _returnWidget =
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text("DATOS MONETARIOS",
        style: TextStyle(fontSize: 12.0, color: Colors.black87)),
    const SizedBox(height: 5.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Has a trabajar",
            style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        Text('${(hasTrabajadas).toStringAsFixed(2)} has',
            style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    ),
    const SizedBox(height: 15.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Precio por ha",
            style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        Text(
            Money.fromNumWithCurrency(
                    ordenLaboreo.precioHaPesos, Constants.monedaAR)
                .toString(),
            style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    ),
    const SizedBox(height: 5.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total laboreo en pesos",
            style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        Text(
            Money.fromNumWithCurrency(
                    ordenLaboreo.totalPesos, Constants.monedaAR)
                .toString(),
            style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    ),
    const SizedBox(height: 15.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Cotización dolar",
            style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        Text(
            Money.fromNumWithCurrency(
                    ordenLaboreo.tipoCambio, Constants.monedaAR)
                .toString(),
            style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    ),
    const SizedBox(height: 5.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Precio por ha en US\$",
            style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        Text(
            Money.fromNumWithCurrency(
                    ordenLaboreo.precioHaDolar, Constants.monedaUSD)
                .toString(),
            style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    ),
    const SizedBox(height: 5.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total laboreo en dolares",
            style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        Text(
            Money.fromNumWithCurrency(
                    ordenLaboreo.totalDolar, Constants.monedaUSD)
                .toString(),
            style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    ),
  ]);

  return _returnWidget;
}

// * -------------------------------------------------------------------------------------------------- solapa 1
Widget _datosPrincipales(ObtenerOrdenDeLaboreoIngenieroDetalleResponse r,
    String gEconomicoId, String empresaId) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      showNroYEstadoOL(r.ol!.olId, r.ol!.estado, gEconomicoId, empresaId),
      const SizedBox(height: 15.0),

      //* ---------- CAMPAÑA
      Row(children: [
        Expanded(
            child: Text('CAMPAÑA  ${r.ol!.campania}',
                style: const TextStyle(fontSize: 12.0, color: Colors.black87))),
      ]),
      const Divider(height: 30.0),

      Row(
        children: [
          Expanded(
            flex: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowCabeceraOLIngeniero(
                  cereal: r.ol!.cereal,
                  ea: r.ol!.ea,
                  fecVto: r.ol!.fecVto,
                  ing: r.ol!.ing,
                  laboreo: r.ol!.laboreo,
                  contratista: r.ol!.con,
                  fecEmi: r.ol!.fecEmi,          //!-- Add 2.8
                ),
                const Divider(height: 30.0),
                showDepositosOL(r.ol!.uao, r.ol!.uad, true),
                showObservacionOL(r.ol!.obs, true),
                _getPrecios(r.ol!)
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

// * -------------------------------------------------------------------------------------------------- solapa 2
Widget _totalInsumos(ObtenerOrdenDeLaboreoIngenieroDetalleResponse r) {
  int registro = 0;

  return Column(
    children: [
      const SizedBox(height: 10.0),
      Text(
          r.ol!.listaTotalInsumos.isEmpty
              ? 'No existen insumos asociados'
              : 'Total de insumos a utilizar',
          style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold)),
      const SizedBox(height: 20.0),
      ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => Container(),
          itemCount: r.ol!.listaTotalInsumos.length,
          itemBuilder: (BuildContext context, int index) {
            OLTotalInsumoItem dataItem = r.ol!.listaTotalInsumos[index];
            registro++;
            return ShowOLInsumo(insumoItem: dataItem, registro: registro);
          }),
    ],
  );
}

// * -------------------------------------------------------------------------------------------------- LISTA DE INSUMOS TOTAL
// ignore: must_be_immutable
class ShowOLInsumo extends StatelessWidget {
  OLTotalInsumoItem insumoItem;
  int registro;

  ShowOLInsumo({
    Key? key,
    required this.insumoItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Column(
        children: [
          //* ---------- Insummo
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text(insumoItem.art.toString(),
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.black54))),
                  const Expanded(child: SizedBox(width: 10.0)),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(insumoItem.total.toStringAsFixed(2),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold)),
                      Text(insumoItem.umo.toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.black54)),
                    ],
                  )),
                ]),
          ),
        ],
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- solapa 3
Widget _totalInsumosPorLotes(ObtenerOrdenDeLaboreoIngenieroDetalleResponse r) {
  int registro = 0;

  List<Widget> _listaW = r.ol!.listaDetalleLotes.map((e) {
    String _lote = e.loteNombre.toCapitalized();
    String _cereal = e.cereal.toCapitalized();
    double _has = e.cantHasParciales;

    //- Fix 2 - para no mostrar lotes de mas a pesar de que estan guardados
    bool showLote = !(e.listaDetalleLoteInsumos.isEmpty && _has == 0.0);
    if (showLote == false) return Container();

    return ListTileTheme(
        tileColor: kTBackgroundBtnHome.withOpacity(0.10),
        child: ExpansionTile(
          iconColor: Colors.black54,
          collapsedIconColor: Colors.black54,
          tilePadding: const EdgeInsets.only(left: 2, right: 20),
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_lote.toCapitalized(),
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0)),
                Text('${_cereal.trim()}  ${_has.toString()} has',
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13.0)),
              ],
            ),
          ),
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: kTBackgroundBtnHome,
                  width: 3.0,
                ),
              )),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(),
                  itemCount: e.listaDetalleLoteInsumos.length,
                  itemBuilder: (BuildContext context, int index) {
                    OLDetalleLoteInsumoItem dataItem =
                        e.listaDetalleLoteInsumos[index];
                    registro++;
                    return ShowOLInsumoLote(
                        insumoItem: dataItem, registro: registro);
                  }),
            ),
          ],
        ));
  }).toList();

  return Column(
    children: [
      const SizedBox(height: 18.0),
      const Text('Insumos por Lotes',
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold)),
      const SizedBox(height: 20.0),
      Column(children: _listaW),
    ],
  );
}

// * -------------------------------------------------------------------------------------------------- LISTA DE INSUMOS TOTAL
// ignore: must_be_immutable
class ShowOLInsumoLote extends StatelessWidget {
  OLDetalleLoteInsumoItem insumoItem;
  int registro;

  ShowOLInsumoLote({
    Key? key,
    required this.insumoItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Column(
        children: [
          //* ---------- NRO + ESTADO
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(insumoItem.art.toString(),
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.black54)),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 13.0, color: Colors.black38),
                              children: <TextSpan>[
                                //const TextSpan(text: 'DOSIS  '),
                                TextSpan(
                                    text: insumoItem.dosis.toStringAsFixed(4),
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        '  ${insumoItem.umo.toString()} /ha.'),
                              ],
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(insumoItem.total.toStringAsFixed(2),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                          Text(insumoItem.umo.toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.black54)),
                        ],
                      )),
                ]),
          ),
        ],
      ),
    );
  }
}
