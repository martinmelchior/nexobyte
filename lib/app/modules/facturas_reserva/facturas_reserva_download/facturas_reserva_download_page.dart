import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/generico_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'facturas_reserva_download_controller.dart';


class FacturasReservaDownloadPage extends GetView<FacturasReservaDownloadController> {

  const FacturasReservaDownloadPage({Key? key}) : super(key: key);

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
              title: Text("Artículos Pendientes\n${controller.itemResumenCtaCte.cliente}", style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor)),
              centerTitle: true,
            ),
            body: controller.obx(
                (state)=> ShowComprobantes(response: state!),
                onLoading: const MyProgressIndicactor(mensaje: 'Generando reporte de\nartículos pendientes !'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTLightPrimaryColor),
              ),
    );
  }
}


class ShowComprobantes extends StatelessWidget {

  final FacturasReservaDownloadController controller = Get.find<FacturasReservaDownloadController>();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final FileDataXlsPdfResponse response;

  ShowComprobantes({Key? key, 
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async => await controller.descargarYCompartir(),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kTLightPrimaryColor) ),
          child: const Text('Compartir archivo', style: TextStyle(fontSize: 12.0),)
        ),
        Expanded(
          child: SfPdfViewer.network(response.linkPdf!, key: _pdfViewerKey, canShowPaginationDialog: false, initialZoomLevel: 3.0,)),
      ],
    );
  }
}


