// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../model.dart';
import 'ver_comprobante_sin_apirest_controller.dart';

class VerComprobanteSinApiRestPage extends GetView<VerComprobanteSinApiRestController> {
  
  const VerComprobanteSinApiRestPage({Key? key}) : super(key: key);

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
              const Text("Comprobante",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Sora',
                      color: kTAllLabelsColor)),
              Obx(() => Text(controller.archivo.value,
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Sora',
                      color: Colors.green,
                      fontWeight: FontWeight.bold))),
            ],
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(Icons.share),
          backgroundColor: kTBackgroundColorBtnIngresarLogin,
          foregroundColor: Colors.white,
          onPressed: () async { 
            await controller.descargarYCompartir();
          },
        ),
        body: controller.obx(
          (state) => ShowComprobantes(response: state!),
          onLoading: const MyProgressIndicactor(mensaje: 'Aguarde un instante !'),
          onEmpty: const MyDataNotFoundMessage(),
          onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTLightPrimaryColor),
        ));
  }
}

class ShowComprobantes extends StatelessWidget {

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final DownloadComprobanteResponse response;

  ShowComprobantes({
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Container(
                height: 60.0,
                color: Colors.transparent,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: response.listaDeComprobantes.length + 1,
                  itemBuilder: (context, index) {
                    Widget chip;
                    if (index == 0)
                    {
                      chip = createButton(DownloadComprobante(fileExtension: response.fileExtension, fileName: response.fileName, fileUrl: response.fileUrl)); 
                    }
                    else
                    {
                      chip = createButton(response.listaDeComprobantes[index - 1]);
                    }
                    return chip;
                  },
                ),
              ),
              Expanded(
                //flex: 12,
                child: SfPdfViewer.network(response.fileUrl!, key: _pdfViewerKey, canShowPaginationDialog: false)
              ),
            ],
          );
  }
}

createButton(DownloadComprobante comprobante) {
  final VerComprobanteSinApiRestController controller = Get.find<VerComprobanteSinApiRestController>();
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white60),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20.0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
        child: Text(
          comprobante.fileName!,
          style: const TextStyle(color: kTAllLabelsColor, fontSize: 13),
        ),
        onPressed: () {
          controller.onShowSelectedFile(comprobante);
        },
    ),
  ); 

}
