
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:tab_container/tab_container.dart';
import '../model/analisis_de_mani_model.dart';
import 'analisis_item_controller.dart';

// ignore: must_be_immutable
class AnalisisItemPage extends GetView<AnalisisItemController> {

  const AnalisisItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late TextTheme textTheme = Theme.of(context).textTheme; 

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 10.0,
        iconTheme: const IconThemeData(color: kTIconColor),
        title: const Text("Detalle  del  Análisis", style: TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
      ),
      body: controller.obx(
              (state) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShowItem(item: controller.dataShowed),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: TabContainer(
                      selectedTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 12.0, color: Colors.black87),
                      unselectedTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 12.0, color: Colors.black87),
                      colors: const [
                        kTColorsTabsAnalisis,
                        kTColorsTabsAnalisis,
                        kTColorsTabsAnalisis,
                        kTColorsTabsAnalisis,
                      ],
                      children: [
                        ShowMuestraSucia(item: controller.dataShowed),
                        ShowMuestraLimpia(item: controller.dataShowed),
                        ShowMermas(item: controller.dataShowed),
                        ShowAlfa(item: controller.dataShowed),
                      ],
                      tabs: const [
                        'MUESTRA\nSUCIA',
                        'MUESTRA\nLIMPIA',
                        'MERMAS',
                        'AFLA',
                      ],
                    ),
                  ),
                ],
              ),
              onLoading: const MyProgressIndicactor(mensaje: 'Buscando Análisis de Mani !'),
              onEmpty: const MyDataNotFoundMessage(),
              onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
      ),
    );
  }
}


//*--------------------------------------------------------------------------- Show muestra sucia
class ShowMuestraSucia extends StatelessWidget {
  
  AnalisisDeMani item;

  ShowMuestraSucia({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(width: 1, color: Colors.black12, style: BorderStyle.solid),
                ),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(4),
                },
                children: <TableRow>[
                  getTableRow('Peso muestra sucia', item.pesoMuestraSucia ?? 0, 0.0),
                  getTableRow('Cuerpos Extraños', item.cuerposExtranios ?? 0, item.cuerposExtraniosPorcentaje ?? 0),
                  getTableRow('Tierra', item.tierra ?? 0, item.tierraPorcentaje ?? 0),
                  getTableRow('Piedra', item.piedra ?? 0, item.piedraPorcentaje ?? 0),
                  getTableRow('Granos Sueltos', item.granosSueltos ?? 0, item.granosSueltosPorcentaje ?? 0),
                  getTableRow('Chala', item.chala ?? 0, 0),
                  getTableRow('Manipuleo', item.manipuleoMuestraSucia ?? 0, item.manipuleoMuestraSuciaPorcentaje ?? 0),
                  getTableRowString('Agroquímicos Presentes', item.agroquimicosPresentes! ? 'SI' : 'NO', ''),
                ],
              ),
          
        ),
      ],
    );
  }
}

//*--------------------------------------------------------------------------- Show muestra LIMPIA
class ShowMuestraLimpia extends StatelessWidget {
  
  AnalisisDeMani item;

  ShowMuestraLimpia({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(width: 1, color: Colors.black12, style: BorderStyle.solid),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(4),
            },
            children: <TableRow>[
              getTableRow('Peso muestra Limpia', item.pesoMuestraLimpia ?? 0, 0),
              getTableRowString('Peso muestra Limpia Teórico', '${item.pesoMuestraLimpiaTeorico!.toStringAsFixed(2)} grs', ''),
              getTableRowString('Humedad', '${item.humedadPorcentaje!.toStringAsFixed(2)} %', '${item.humedadCoeficiente.toString()} coef.'),
              getTableRow('Caja/Grano', item.cajaGrano ?? 0, item.cajaGranoPorcentaje ?? 0),
              getTableRow('Zarandeo  38/42', item.zarandeo3842 ?? 0, item.zarandeo3842Porcentaje ?? 0),
              getTableRow('Zarandeo  40/50', item.zarandeo4050 ?? 0, item.zarandeo4050Porcentaje ?? 0),
              getTableRow('Zarandeo  50/60', item.zarandeo5060 ?? 0, item.zarandeo5060Porcentaje ?? 0),
              getTableRow('Zarandeo  60/70', item.zarandeo6070 ?? 0, item.zarandeo6070Porcentaje ?? 0),
              getTableRow('Partido', item.partido ?? 0, item.partidoPorcentaje ?? 0),
              getTableRow('Industria', item.industria ?? 0, item.industriaPorcentaje ?? 0),
              getTableRow('Industria Teorico', item.industriaTeorico ?? 0, item.industriaTeoricoPorcentaje ?? 0),             
            ],
          ),
    );
  }
}

//*--------------------------------------------------------------------------- Show MERMAS
class ShowMermas extends StatelessWidget {
  
  AnalisisDeMani item;

  ShowMermas({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Table(
             border: const TableBorder(
              horizontalInside: BorderSide(width: 1, color: Colors.black12, style: BorderStyle.solid),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(4),
            },
            children: <TableRow>[
              getTableRow('Brotado', item.brotado ?? 0, item.brotadoPorcentaje ?? 0),
              getTableRow('Ardido', item.ardido?? 0, item.ardidoPorcentaje ?? 0),
              getTableRow('Manchados', item.manchados ?? 0, item.manchadosPorcentaje?? 0),
              getTableRow('Helados', item.helado ?? 0, item.heladoPorcentaje ?? 0),
              getTableRow('Moho Interno', item.mohoInterno ?? 0, item.mohoInternoPorcentaje ?? 0),
              getTableRow('Moho Externo', item.mohoExterno ?? 0, item.mohoExternoPorcentaje ?? 0),
              getTableRow('Carbón', item.carbon ?? 0, item.carbonPorcentaje ?? 0),
              getTableRow('Insecto', item.insectos ?? 0, item.insectosPorcentaje ?? 0),
              getTableRow('Descompuesto', item.descompuesto ?? 0, item.descompuestoPorcentaje ?? 0),
              getTableRow('Manipuleo', item.manipuleoMuestraLimpia ?? 0, item.manipuleoMuestraLimpiaPorcentaje ?? 0),
            ],
          ),
    );
  }
}

//*--------------------------------------------------------------------------- Show ALFA
class ShowAlfa extends StatelessWidget {
  
  AnalisisDeMani item;

  ShowAlfa({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
              children: [
                const SizedBox(height: 20.0),
                Text(item.aflatoxinas!, style: const TextStyle(fontSize: 12.0)),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: item.tieneAfla ?? false,
                  child: Row(
                    children: [
                      Image.asset(Constants.kImgAfla, width: 30, height: 30),
                      const SizedBox(width: 10.0),
                      Text('AFLATOXINA:   ${item.valorAfla.toString()}   PPB', style: const TextStyle(fontSize: 12, color: Colors.black54))
                    ],
                  )),
              ],
            ),
      ),
    );
  }
}

//*--------------------------------------------------------------------------- getTableRowSinUM
TableRow getTableRowString(String label, String valor, String porcentaje, {double alto = 35.0}) {
  return TableRow(
    children: <Widget>[
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8.0), color: Colors.black.withAlpha(20), height: alto, child: Center(child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 11.0, fontFamily: 'Sora'))))),
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: SizedBox(height: alto,child: Center(child: Text(valor, style: const TextStyle(fontSize: 12.0, fontFamily: 'Sora'), textAlign: TextAlign.end)))),
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: SizedBox(height: alto,child: Center(child: Text(porcentaje, style: const TextStyle(fontSize: 12.0, fontFamily: 'Sora'), textAlign: TextAlign.end))))
    ],
  );
}

//*--------------------------------------------------------------------------- getTableRowSinUM
TableRow getTableRowSinUM(String label, double valor, double porcentaje, {double alto = 35.0}) {

  String _v = '';
  String _p = '';

  if (valor != 0) 
  {
    _v += valor.toString();
  }
  if (porcentaje != 0)
  {
    _p += porcentaje.toStringAsFixed(2);
  }

  return TableRow(
    children: <Widget>[
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8.0), color: Colors.black.withAlpha(20), height: alto, child: Center(child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 11.0, fontFamily: 'Sora'))))),
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: SizedBox(height: alto,child: Center(child: Text(_v, style: const TextStyle(fontSize: 12.0, fontFamily: 'Sora'), textAlign: TextAlign.end)))),
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: SizedBox(height: alto,child: Center(child: Text(_p, style: const TextStyle(fontSize: 12.0, fontFamily: 'Sora'), textAlign: TextAlign.end))))
    ],
  );
}
//*--------------------------------------------------------------------------- getTableRow
TableRow getTableRow(String label, double valor, double porcentaje, {double alto = 35.0}) {

  String _v = '';
  String _p = '';

  if (valor != 0) 
  {
    _v += '$valor  grs';
  }
  if (porcentaje != 0)
  {
    _p += '${porcentaje.toStringAsFixed(2)}  %';
  }

  return TableRow(
    children: <Widget>[
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8.0), color: Colors.black.withAlpha(20), height: alto, child: Center(child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 11.0, fontFamily: 'Sora'))))),
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: SizedBox(height: alto,child: Center(child: Text(_v, style: const TextStyle(fontSize: 12.5, fontFamily: 'Sora'), textAlign: TextAlign.end)))),
      TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: SizedBox(height: alto,child: Center(child: Text(_p, style: const TextStyle(fontSize: 12.5, fontFamily: 'Sora'), textAlign: TextAlign.end))))
    ],
  );
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowItem extends StatelessWidget {

  final AnalisisItemController controller = Get.find<AnalisisItemController>();

  AnalisisDeMani item;

  ShowItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#  ${item.analisisManiEnCajaId.toString()}', style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
                Text(DateFormat("dd-MM-yyyy").format(item.fecha!), style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 5.0),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RoundedContainer(kTLabelTextBoxLogin, "CP", fontSize: 11.0),
                      const SizedBox(width: 5.0),
                      Flexible(child: Text(item.cartaPorteNro.toString(), style: const TextStyle(fontSize: 12.5, color: Colors.black54))),
                      const SizedBox(width: 20.0),
                      Flexible(child: Text('${item.kilosDescargadosCPE.toString()} Kgs desc.', style: const TextStyle(fontSize: 12.5, color: Colors.black54))),
                    ],
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const RoundedContainer(kTLabelTextBoxLogin, "CTG", fontSize: 11.0),
                const SizedBox(width: 25.0),
                Text(item.ctg.toString(), style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
              ],
            ),

            Visibility(
              visible: item.explotacion == null ? false : true,
              child: Column(
                children: [
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RoundedContainer(kTLabelTextBoxLogin, "EA", fontSize: 11.0),
                      const SizedBox(width: 25.0),
                      Text(item.explotacion.toString(), style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
