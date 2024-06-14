
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/adelantos/utils/adelanto_constants.dart';
import 'package:nexobyte/app/modules/adelantos/utils/adelanto_util.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money2/money2.dart';
import 'adelanto_lista_controller.dart';

// ignore: must_be_immutable
class AdelantoListaPage extends GetView<AdelantoListaController> {
  
  int registro = 0;

  AdelantoListaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: const Icon(Icons.add),
        backgroundColor: kTBackgroundColorBtnIngresarLogin,
        foregroundColor: Colors.white,
        onPressed: () async {
            bool reloadList = await Get.toNamed(AppRoutes.rSolicitudAdelantoItem, 
                                                  arguments: { 
                                                    "solicitudId": -1,
                                                    "itemResumenCtaCte": controller.itemResumenCtaCte 
                                                  });
            if (reloadList)
            {
              await controller.obtenerSolicitudes(controller.gec);
            }
        },
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 10.0,
        iconTheme: const IconThemeData(color: kTIconColor),
        title: const Text('Solicitudes de Adelantos', style: TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
          bottom: PreferredSize(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CUENTA ORIGEN DE FONDOS', style:  TextStyle(fontSize: 12.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
                  Text(controller.itemResumenCtaCte.cliente, style: const TextStyle(fontSize: 14.0, fontFamily: 'Sora', color: kTRedColor)),
                ],
              ),
              height: 80.0
            ),
            preferredSize: const Size.fromHeight(80.0),
          ),        
      ),
      body: controller.obx(
        (state) => 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
                  color: kTLabelEspecieResumenHome,
                  backgroundColor: kTLightPrimaryColor3,
                  onRefresh: () async => await controller.obtenerSolicitudes(controller.gec),
                  child: ListView.separated(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => Container(),
                    itemCount: state!.listaDeSolicitudes.length,
                    itemBuilder: (BuildContext context, int index) {
                      Solicitud dataItem = state.listaDeSolicitudes[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () async {
                            bool reloadList = await Get.toNamed(AppRoutes.rSolicitudAdelantoItem, 
                                                    arguments: { 
                                                      "solicitudId": dataItem.solicitudId,
                                                      "itemResumenCtaCte": controller.itemResumenCtaCte 
                                                    });
                            if (reloadList)
                            {
                              await controller.obtenerSolicitudes(controller.gec);
                            }
                          },
                          child: Card(
                            child: ShowItem(dataItem: dataItem),                      
                          ),
                        ),
                      );
                    })),
          ),
          onLoading: const MyProgressIndicactor(mensaje: 'Buscando Solicitudes de Adelantos !'),
          onEmpty: const Center(child: MyDataNotFoundMessage(mensaje: "No tienes Solicitudes de Adelantos !\n\nAgrega una desde el botón inferior !", colorText: kTAllLabelsColor)),
          onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTRedColor),
        ),
    );
  }
}

const kElevation = 15.0;
const kPITipos = 8.0; 
const kTextStyleLblTipos = TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 70, 70, 70));
const kTextStyleImportes = TextStyle(fontSize: 13.0, color: Colors.black87);
const kTextStyleTotal = TextStyle(fontSize: 19.0, color: Colors.indigoAccent, fontWeight: FontWeight.normal);
const kTextStyleLblTipos2 = TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 70, 70, 70));
const kTextStyleLblTipos3 = TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 70, 70, 70));
const kWHIcon = 30.0;

const kTextStyleLblTipos2Rechazado = TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 70, 70, 70), decoration: TextDecoration.lineThrough);
const kTextStyleLblTipos3Rechazado = TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 70, 70, 70), decoration: TextDecoration.lineThrough);


const kTextStyleImportesEfectivo = TextStyle(fontSize: 14.0, color: Colors.green);
const kTextStyleImportesCheques = TextStyle(fontSize: 14.0, color: Colors.blue);
const kTextStyleImportesPropias = TextStyle(fontSize: 14.0, color: Colors.orange);
const kTextStyleImportesOtras = TextStyle(fontSize: 14.0, color: Colors.red);

const kTextStyleImportesEfectivoRechazado = TextStyle(fontSize: 14.0, color: Colors.green, decoration: TextDecoration.lineThrough);
const kTextStyleImportesChequesRechazado = TextStyle(fontSize: 14.0, color: Colors.blue, decoration: TextDecoration.lineThrough);
const kTextStyleImportesPropiasRechazado = TextStyle(fontSize: 14.0, color: Colors.orange, decoration: TextDecoration.lineThrough);
const kTextStyleImportesOtrasRechazado = TextStyle(fontSize: 14.0, color: Colors.red, decoration: TextDecoration.lineThrough);

// * -------------------------------------------------------------------------------------------------- ShowTitle
class ShowItem extends StatelessWidget {

  const ShowItem({
    Key? key,
    required this.dataItem,
  }) : super(key: key);

  final Solicitud? dataItem;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NRO:   ${dataItem!.solicitudId.toString()}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AdelantoUtils.getBackColorEstadoAdelanto(dataItem!.estado!))),
                  Text(DateFormat("dd-MM-yyyy  ( hh:mm )").format(dataItem!.fechaCarga!), style: const TextStyle(fontSize: 11.0, color: Colors.black54)),
                ],
              ),
              SizedBox(width: Get.width * 0.1),    
              Expanded(child: RoundedContainer(AdelantoUtils.getBackColorEstadoAdelanto(dataItem!.estado!),  dataItem!.estado!, fontSize: 12.0)),
            ],
          ),
          Visibility(
            visible: dataItem!.estado! == "RECHAZADA",
            child: Column(
              children: [
                const SizedBox(height: 5.0),
                Text(dataItem!.motivoDeRechazo!, style: TextStyle(fontSize: 13, color: AdelantoUtils.getBackColorEstadoAdelanto(dataItem!.estado!))),
              ]
            )
          ),
          const SizedBox(height: 15.0),
          const Text('CUENTA ORIGEN', style: TextStyle(fontSize: 10.0, color: Colors.black54)),
          Text('${dataItem!.cliente!.toUpperCase()}  (${dataItem!.nroCtaCte})' , style: const TextStyle(fontSize: 14.0, color: Colors.black87)),
          Text(dataItem!.empresa!.toUpperCase() , style: const TextStyle(fontSize: 12.0, color: Colors.black87)),

          Visibility(
            visible: dataItem!.observacion!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15.0),
                const Text('COMENTARIO', style: TextStyle(fontSize: 10.0, color: Colors.black54)),
                Text(dataItem!.observacion!.toLowerCase(), style: const TextStyle(fontSize: 13.0, color: Colors.black87)),
              ],
            ),
          ),
          
          const SizedBox(height: 20.0),
          
          //*---------------------------------------- EFECTIVO
          Visibility(
            visible: dataItem!.totalEfectivo! > 0.0,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total EFECTIVO', style: kTextStyleLblTipos, textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  const SizedBox(width: 20.0),
                  Text(Money.fromNumWithCurrency(dataItem!.totalEfectivo!, Constants.monedaAR).toString(), style: kTextStyleImportesEfectivo),
                  const SizedBox(width: 20.0),
                  Image.asset(AdelantoConstants.kImgEfectivo, width: kWHIcon, height: kWHIcon),
                ],
              ),
            ),
          ),  
          
          //*---------------------------------------- CHEQUES
          Visibility(
            visible: dataItem!.totalCheques! > 0.0,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total CHEQUES', style: kTextStyleLblTipos, textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(Money.fromNumWithCurrency(dataItem!.totalCheques!, Constants.monedaAR).toString(), style: kTextStyleImportesCheques),                  
                    const SizedBox(width: 20.0),
                    Image.asset(AdelantoConstants.kImgCheques, width: kWHIcon, height: kWHIcon),
                  ],
              ),
            ),
          ),  

          //*---------------------------------------- CUENTAS PROPIAS
          Visibility(
            visible: dataItem!.totalTransferenciasPropias! > 0.0,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total CUENTAS PROPIAS', style: kTextStyleLblTipos, textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(Money.fromNumWithCurrency(dataItem!.totalTransferenciasPropias!, Constants.monedaAR).toString(), style: kTextStyleImportesPropias),                  
                    const SizedBox(width: 20.0),
                    Image.asset(AdelantoConstants.kImgTransferencia2, width: kWHIcon, height: kWHIcon),
                  ],
              ),
            ),
          ),  

          //*---------------------------------------- OTRAS CTAS
          Visibility(
            visible: dataItem!.totalTransferenciasOtras! > 0.0,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total OTRAS CTAS', style: kTextStyleLblTipos, textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(Money.fromNumWithCurrency(dataItem!.totalTransferenciasOtras!, Constants.monedaAR).toString(), style: kTextStyleImportesOtras),                  
                    const SizedBox(width: 20.0),
                    Image.asset(AdelantoConstants.kImgTransferencia1, width: kWHIcon, height: kWHIcon),
                  ],
              ),
            ),
          ),  
          const SizedBox(height: 10.0),
          Row(
            children: [
              //*---------------------------------------- total solicitud
              Expanded(
                child: Card(
                  elevation: kElevation,
                  child: Padding(
                    padding: const EdgeInsets.all(kPITipos),
                    child: Column(
                      children: [
                        const SizedBox(height: 5.0),
                        Text(Money.fromNumWithCurrency(dataItem!.totalSolicitud!, Constants.monedaAR).toString(), style: kTextStyleTotal),
                        const SizedBox(height: 3.0),
                        const Text('Total de la SOLICITUD', style: kTextStyleLblTipos),
                        const SizedBox(height: 3.0),
                      ]
                    ),
                  ),
                ),
              ),
            ]
          ),

        ],
      ),
    );
  }
}