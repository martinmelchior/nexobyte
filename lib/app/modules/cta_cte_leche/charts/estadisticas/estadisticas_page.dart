import 'package:flutter/gestures.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'estadisticas_controller.dart';


class EstadisticasPage extends GetView<EstadisticasController>  {

  const EstadisticasPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: kTflexibleSpace,
            elevation: 10.0,
            backgroundColor: kTLightPrimaryColor,
            iconTheme: const IconThemeData(
              color: kTIconColor, //change your color here
            ),
            title: Text("Estadísticas\n${controller.parameter.cliente}", style: const TextStyle(color: kTAllLabelsColor, fontSize: 15, fontFamily: 'Sora')),
            centerTitle: true,
            bottom: const TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 8.0, color: kTAllLabelsColor),
              ),
              isScrollable: true,
              tabs: [
                Tab(child: Text("Grasa Butirosa", style: TextStyle(fontSize: 14, color: kTAllLabelsColor))),
                Tab(child: Text("Proteina", style: TextStyle(fontSize: 14, color: kTAllLabelsColor))),
                Tab(child: Text("UFC", style: TextStyle(fontSize: 14, color: kTAllLabelsColor))),
                Tab(child: Text("RCS", style: TextStyle(fontSize: 14, color: kTAllLabelsColor))),
                Tab(child: Text("Temperatura", style: TextStyle(fontSize: 14, color: kTAllLabelsColor))),
              ]
            ),
        ),
          backgroundColor: Colors.white,
                body: controller.obx(
                  (state) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        children: [
                          butirosa(),
                          proteinas(),
                          ufc(),
                          rcs(),
                          temperatura(),
                        ],
                      ),
                    )
                ),
                onLoading: const Center(child: MyProgressIndicactor(mensaje: 'Buscando  información  !')),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
              ),
            ),
      ),
    );
  }

  Widget butirosa() {
    String _referencia = controller.listaButirosa.isEmpty ? '' : controller.listaButirosa[0].ref.toString() + " %";
    return SfCartesianChart(
        tooltipBehavior: controller.tooltipBehavior,
        trackballBehavior: controller.trackballBehavior,
        isTransposed: true,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: controller.minimoB,
          maximum: controller.maximoB,
        ),
        legend: Legend(
          isVisible: true,
          opacity: 0.8,
        ),
        series: <ChartSeries<ChartDataButirosa, String>>[
            ColumnSeries<ChartDataButirosa, String>(
                animationDelay: 1000,
                animationDuration: 2000,
                dataSource: controller.listaButirosa,
                pointColorMapper:(ChartDataButirosa data, _) => data.color,
                xValueMapper: (ChartDataButirosa data, _) => data.x,
                yValueMapper: (ChartDataButirosa data, _) => data.y,
                name: "Valor grasa butirosa"
            ),
            // LineSeries<ChartData, String>(
            //   color: Colors.red,
            //   dataSource: controller.listChartData,
            //   xValueMapper: (ChartData data, _) => data.x,
            //   yValueMapper: (ChartData data, _) => data.min,
            //   name: "Mínimo"
            // ),
            LineSeries<ChartDataButirosa, String>(
              color: Colors.black,
              dataSource: controller.listaButirosa,
              xValueMapper: (ChartDataButirosa data, _) => data.x,
              yValueMapper: (ChartDataButirosa data, _) => data.ref,
              name: "Referencia " + _referencia
            ),
        ]
      );
  }

  Widget proteinas() {
    String _referencia = controller.listaProteinas.isEmpty ? '' : controller.listaProteinas[0].ref.toString() + " %";
    return SfCartesianChart(
        tooltipBehavior: controller.tooltipBehavior,
        trackballBehavior: controller.trackballBehavior,
        isTransposed: true,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: controller.minimoP,
          maximum: controller.maximoP,
        ),
        legend: Legend(
          isVisible: true,
          opacity: 0.8,
        ),
        series: <ChartSeries<ChartDataProteinas, String>>[
            ColumnSeries<ChartDataProteinas, String>(
                animationDelay: 1000,
                animationDuration: 2000,
                dataSource: controller.listaProteinas,
                pointColorMapper:(ChartDataProteinas data, _) => data.color,
                xValueMapper: (ChartDataProteinas data, _) => data.x,
                yValueMapper: (ChartDataProteinas data, _) => data.y,
                name: "Valor proteina"
            ),
            // LineSeries<ChartData, String>(
            //   color: Colors.red,
            //   dataSource: controller.listChartData,
            //   xValueMapper: (ChartData data, _) => data.x,
            //   yValueMapper: (ChartData data, _) => data.min,
            //   name: "Mínimo"
            // ),
            LineSeries<ChartDataProteinas, String>(
              color: Colors.black,
              dataSource: controller.listaProteinas,
              xValueMapper: (ChartDataProteinas data, _) => data.x,
              yValueMapper: (ChartDataProteinas data, _) => data.ref,
              name: "Referencia " + _referencia
            ),
        ]
      );
  }

  Widget ufc() {
    String _referencia = controller.listaUFC.isEmpty ? '' : controller.listaUFC[0].ref.toString();
    return SfCartesianChart(
        tooltipBehavior: controller.tooltipBehavior,
        trackballBehavior: controller.trackballBehavior,
        isTransposed: true,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: controller.minimoUFC,
          maximum: controller.maximoUFC,
        ),
        legend: Legend(
          isVisible: true,
          opacity: 0.8,
        ),
        series: <ChartSeries<ChartDataUFC, String>>[
            ColumnSeries<ChartDataUFC, String>(
                animationDelay: 1000,
                animationDuration: 2000,
                dataSource: controller.listaUFC,
                pointColorMapper:(ChartDataUFC data, _) => data.color,
                xValueMapper: (ChartDataUFC data, _) => data.x,
                yValueMapper: (ChartDataUFC data, _) => data.y,
                name: "Valor UFC"
            ),
            // LineSeries<ChartData, String>(
            //   color: Colors.red,
            //   dataSource: controller.listChartData,
            //   xValueMapper: (ChartData data, _) => data.x,
            //   yValueMapper: (ChartData data, _) => data.min,
            //   name: "Mínimo"
            // ),
            LineSeries<ChartDataUFC, String>(
              color: Colors.black,
              dataSource: controller.listaUFC,
              xValueMapper: (ChartDataUFC data, _) => data.x,
              yValueMapper: (ChartDataUFC data, _) => data.ref,
              name: "Referencia " + _referencia
            ),
        ]
      );
  }

  Widget rcs() {
    String _referencia = controller.listaRCS.isEmpty ? '' : controller.listaRCS[0].ref.toString();
    return SfCartesianChart(
        tooltipBehavior: controller.tooltipBehavior,
        trackballBehavior: controller.trackballBehavior,
        isTransposed: true,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: controller.minimoRCS,
          maximum: controller.maximoRCS,
        ),
        legend: Legend(
          isVisible: true,
          opacity: 0.8,
        ),
        series: <ChartSeries<ChartDataRCS, String>>[
            ColumnSeries<ChartDataRCS, String>(
                animationDelay: 1000,
                animationDuration: 2000,
                dataSource: controller.listaRCS,
                pointColorMapper:(ChartDataRCS data, _) => data.color,
                xValueMapper: (ChartDataRCS data, _) => data.x,
                yValueMapper: (ChartDataRCS data, _) => data.y,
                name: "Valor RCS"
            ),
            // LineSeries<ChartData, String>(
            //   color: Colors.red,
            //   dataSource: controller.listChartData,
            //   xValueMapper: (ChartData data, _) => data.x,
            //   yValueMapper: (ChartData data, _) => data.min,
            //   name: "Mínimo"
            // ),
            LineSeries<ChartDataRCS, String>(
              color: Colors.black,
              dataSource: controller.listaRCS,
              xValueMapper: (ChartDataRCS data, _) => data.x,
              yValueMapper: (ChartDataRCS data, _) => data.ref,
              name: "Referencia " + _referencia
            ),
        ]
      );
  }

  Widget temperatura() {
    String _referencia = controller.listaTemp.isEmpty ? '' : controller.listaTemp[0].ref.toString() + " º";
    return SfCartesianChart(
        tooltipBehavior: controller.tooltipBehavior,
        trackballBehavior: controller.trackballBehavior,
        isTransposed: true,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: controller.minimoT,
          maximum: controller.maximoT,
        ),
        legend: Legend(
          isVisible: true,
          opacity: 0.8,
        ),
        series: <ChartSeries<ChartDataTemperatura, String>>[
            ColumnSeries<ChartDataTemperatura, String>(
              sortingOrder: SortingOrder.ascending,
              sortFieldValueMapper: (ChartDataTemperatura data, _) => data.custom,
                animationDelay: 1000,
                animationDuration: 2000,
                dataSource: controller.listaTemp,
                pointColorMapper:(ChartDataTemperatura data, _) => data.color,
                xValueMapper: (ChartDataTemperatura data, _) => data.custom,
                yValueMapper: (ChartDataTemperatura data, _) => data.temp,
                name: "Temperatura"
            ),
            LineSeries<ChartDataTemperatura, String>(
              color: Colors.black,
              dataSource: controller.listaTemp,
              xValueMapper: (ChartDataTemperatura data, _) => data.custom,
              yValueMapper: (ChartDataTemperatura data, _) => data.ref,
              name: "Referencia " + _referencia,
            ),
        ]
      );
  }
}




