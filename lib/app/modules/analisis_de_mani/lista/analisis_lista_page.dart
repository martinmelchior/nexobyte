import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import '../model/analisis_de_mani_model.dart';
import 'analisis_lista_controller.dart';

// ignore: must_be_immutable
class AnalisisListaPage extends GetView<AnalisisListaController> {
  int registro = 0;

  AnalisisDeMani? dataItem;

  AnalisisListaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _titulo = "Lista de Análisis Cerrados";
    
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        bottom: PreferredSize(
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: ShowHeader(itemResumenAnalisis: controller.itemResumenAnalisis),
              height: 80.0),
          preferredSize: const Size.fromHeight(80.0),
        ),
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: Text(_titulo, style: const TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
      ),
      body: controller.obx(
              (state) => Stack(children: [
                ListView.separated(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => Container(),
                  itemCount: state!.listaDeAnalisisDeMani.length,
                  itemBuilder: (BuildContext context, int index) {
                    dataItem = state.listaDeAnalisisDeMani[index];
                    registro++;
                    return ShowItem(item: dataItem!, registro: registro);
                  }),
                  Obx(() => Visibility(
                    visible: controller.loading.value && controller.itemResumenAnalisis.pageNro > 1,
                        child: const Column(
                          children: [
                            Expanded(child: SizedBox()),
                            SizedBox(
                              width: double.infinity,
                              child: Center(child: kTLpi)),
                          ],
                        ),
                      )),
                  ]),
              onLoading: const MyProgressIndicactor(mensaje: 'Buscando Análisis de Mani !'),
              onEmpty: const MyDataNotFoundMessage(),
              onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: Colors.red),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- SHOW HEADER
class ShowHeader extends StatelessWidget {

  //-- ADD 2.2
  final AnalisisListaController controller = Get.find<AnalisisListaController>();

  final ResumenAnalisisItem itemResumenAnalisis;

  ShowHeader(
      {Key? key, required this.itemResumenAnalisis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(itemResumenAnalisis.clienteProductor.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold,)),
          const SizedBox(height: 8.0),
          Text(itemResumenAnalisis.empresa, style: const TextStyle(
                  fontSize: 14.0,
                  color: kTClientesLabelsColor)),
        ],
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowItem extends StatelessWidget {

  final AnalisisListaController controller = Get.find<AnalisisListaController>();

  AnalisisDeMani item;
  int registro;

  ShowItem({
    Key? key,
    required this.item,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => Get.toNamed(AppRoutes.rAnalisisDeManiItem, 
                            arguments: { 
                              'analisisId':   item.analisisManiEnCajaId,
                              'gEconomicoId': controller.itemResumenAnalisis.gEconomicoId, 
                              'empresaId':    controller.itemResumenAnalisis.empresaId 
                            }) ,
      child: Container(
        decoration: BoxDecoration(
          color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
  	    border: Border(left: BorderSide(
            color: item.tieneAfla ?? false ? kTRedColor : Colors.transparent,
            width: item.tieneAfla ?? false ? 10 : 0),
		  )),
        child: Padding(
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

              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text("Peso muestra SUCIA", textAlign: TextAlign.center),
                        const SizedBox(height: 10.0),
                        Text('${item.pesoMuestraSucia.toString()} grs', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      children: [
                        const Text("Peso muestra LIMPIA", textAlign: TextAlign.center,),
                        const SizedBox(height: 10.0),
                        Text('${item.pesoMuestraLimpia.toString()} grs', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
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
      ),
    );
  }
}
