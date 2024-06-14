import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/model/ol_generica_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'model/notificacion_model.dart';
import 'notificaciones_lista_controller.dart';

// ignore: must_be_immutable
class NotificacionesListaPage extends GetView<NotificacionesListaController> {
  int registro = 0;


  NotificacionesListaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(color: kTIconColor),
        title: const Text("Mis Notificaciones",
            style: TextStyle(fontSize: 18.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
        //-- ADD 2.3
        actions: [
          Obx(() => Visibility(
                visible: controller.acciones.isNotEmpty,
                child: PopupMenuButton(itemBuilder: (context) {
                  return controller.acciones;
                }, onSelected: (value) async {
                  if (value == 0) {
                    await controller.eliminarTodasLasNotificaciones();
                  } else if (value == 1) {
                    await controller.eliminarTodasLasNotificaciones();
                    Get.back();
                    Get.snackbar(
                      "Listo",
                      "Tu notificaciones fueron ELIMINADAS !",
                      colorText: Colors.black87,
                      backgroundColor: Colors.white,
                    );
                  }
                }),
              )),
        ],
      ),
      body: controller.obx(
        (state) => Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                controller: controller.scrollController,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) => Container(),
                itemCount: state!.listaDeNotificaciones.length,
                itemBuilder: (BuildContext context, int index) {
                  //dataItem = state.listaDeNotificaciones[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ExpansionTileCard(
                      baseColor: Colors.white,
                      leading: ShowLeading(dataItem: state.listaDeNotificaciones[index]),
                      title: ShowTitle(dataItem: state.listaDeNotificaciones[index]),
                      children: [
                        const Divider(thickness: 1.0, height: 1.0),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(state.listaDeNotificaciones[index].mensaje),
                              ShowChip(dataItem: state.listaDeNotificaciones[index]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Obx(() => Visibility(
                visible: controller.loading.value && controller.request.pageNro > 1,
                child: const Column(
                  children:  [
                    Expanded(child: SizedBox()),
                    SizedBox(
                        width: double.infinity, child: Center(child: kTLpi)),
                  ],
                ),
              )),
        ]),
        onLoading: const MyProgressIndicactor(mensaje: 'Buscando notificaciones !'),
        onEmpty: const MyDataNotFoundMessage(mensaje: "Aún no tienes notificaciones asignadas !", colorText: kTAllLabelsColor),
        onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTRedColor),
      ),
    );
  }
}

class ShowChip extends StatelessWidget {

  final NotificacionItem? dataItem;

  const ShowChip({
    Key? key,
    required this.dataItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _default = const SizedBox();
    
    //*--------------------------------------------------------------------- MUESTRO ORDEN DE LABOREO
    if (dataItem!.tabla.trim().toUpperCase() == "EA_ORDENESLABOREO" &&
        dataItem!.campo.trim().toUpperCase() == "EA_ORDENLABOREOID" &&
        dataItem!.valor.trim().toUpperCase().isNotEmpty)
        {
          _default = Column(
            children: [
              const SizedBox(height: 15.0),
              ActionChip(
                label: const Text('Ver Orden de Laboreo'),
                labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                onPressed: () => Get.toNamed(AppRoutes.rOLGenerica, 
                                      arguments: OLGenericaDetalleRequest(
                                          gEconomicoId:    dataItem!.gEconomicoId,
                                          empresaId:       dataItem!.empresaId,
                                          olId:            int.parse(dataItem!.valor),
                                          tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                          //!-- Add 2.6
                                          showDatosMonetarios: false,
                                          showDatosMonetariosOperario: false,
                                          operarioClienteId: 0,
                                        )),
                backgroundColor: Colors.white,
                shape: const StadiumBorder(
                  side: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
            ],
          );
        }
    //*--------------------------------------------------------------------- MUESTRO ANALISIS DE MANI
    else if (dataItem!.tabla.trim().toUpperCase() == "MN_Analisis_Mani_En_Caja".toUpperCase() &&
        dataItem!.campo.trim().toUpperCase() == "MN_AnalisisManiEnCajaId".toUpperCase() &&
        dataItem!.valor.trim().toUpperCase().isNotEmpty)
        {
          _default = Column(
            children: [
              const SizedBox(height: 15.0),
              ActionChip(
                label: const Text('Ver resultados de Analisis de Mani'),
                labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                onPressed: () => Get.toNamed(AppRoutes.rAnalisisDeManiItem, 
                                      arguments: { 
                                        'analisisId':   int.parse(dataItem!.valor),
                                        'gEconomicoId': dataItem!.gEconomicoId, 
                                        'empresaId':    dataItem!.empresaId 
                                      }),
                backgroundColor: Colors.white,
                shape: const StadiumBorder(
                  side: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
            ],
          );
        }

    return _default;
    
  }
}

// * -------------------------------------------------------------------------------------------------- ShowTitle
class ShowTitle extends StatelessWidget {
  const ShowTitle({
    Key? key,
    required this.dataItem,
  }) : super(key: key);

  final NotificacionItem? dataItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DateFormat("dd-MM-yyyy  ( hh:mm )").format(dataItem!.fecha!),
            style: const TextStyle(fontSize: 12.0, color: Colors.black87)),
        Text(dataItem!.titulo,
            style: const TextStyle(fontSize: 14.0, color: Colors.black54)),
      ],
    );
  }
}

// * -------------------------------------------------------------------------------------------------- ShowLeading
class ShowLeading extends StatelessWidget {
  const ShowLeading({
    Key? key,
    required this.dataItem,
  }) : super(key: key);

  final NotificacionItem? dataItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(Icons.brightness_1,
            //     size: 11.0,
            //     color: dataItem!.wasRead ? Colors.transparent : Colors.red),
            Container(
              decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 40),
                  blurRadius: 20.0,
                )
              ]),
              child: dataItem!.icon.isBlank == true
                ? _getImageAssetByServicio(dataItem!.servicioCodigo.trim().toUpperCase(), 40.0, 40.0)
                : _getCustomIconFromWeb(dataItem!.icon, 40.0, 40.0)
            ),
          ],
        ),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- _getImageAssetByServicio
_getImageAssetByServicio(servicio, alto, ancho) {
  if (servicio == 'OLA') {
    return Image.asset(Constants.kImgOLA, width: ancho, height: alto);
  } else if (servicio == 'CC') {
    return Image.asset(Constants.kImgCtaCte, width: ancho, height: alto);
  } else if (servicio == 'CCG') {
    return Image.asset(Constants.kImgCtaCteGranos, width: ancho, height: alto);
  } else if (servicio == 'IOL') {
    return Image.asset(Constants.kImgIOL, width: ancho, height: alto);
  } else if (servicio == 'POS') {
    return Image.asset(Constants.kImgPOS, width: ancho, height: alto);
  } else if (servicio == 'LCH') {
    return Image.asset(Constants.kImgTambos, width: ancho, height: alto);
  } else {
    return Image.asset(Constants.kImgAnuncio, width: ancho, height: alto);
  }
}

// * -------------------------------------------------------------------------------------------------- _getImageAssetByServicio
_getCustomIconFromWeb(icon, alto, ancho) {
    return Image.network("${Constants.urlBase}Content/img/${icon.toString().trim()}.png", width: ancho, height: alto);
}
