import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/operarios/resumen_ols/model/resumen_ols.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'package:money2/money2.dart';
import 'resumen_operario_ols_controller.dart';

class ResumenOperariosOlsPage extends GetView<ResumenOperarioOlsController> {

  ResumenOperariosOlsPage({Key? key}) : super(key: key);

  var registro = 0;

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
          title: const Text("Resumen de Has trabajadas",
              style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              controller.obx(
                (state) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: state!.listaDeItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          ResumenOperarioOlsItem item = state.listaDeItems[index];
                          registro++;
                          return ShowResumenItemItem(item: item, registro: registro);
                        }),
                onLoading: const MyProgressIndicactor(mensaje: 'Espere un momento !'),
                onEmpty: const MyDataNotFoundMessage(colorText: kTLightPrimaryColor),
                onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTLightPrimaryColor1),
              ),
          ]
        ));
  }
}




// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowResumenItemItem extends StatelessWidget {

  final ResumenOperarioOlsController _controller = Get.find<ResumenOperarioOlsController>();

  final ResumenOperarioOlsItem item;
  final int registro;

  ShowResumenItemItem({
    Key? key,
    required this.item,
    required this.registro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Widget header = const SizedBox();
    Widget footer = const SizedBox();

    //*---- Intentando hacer algo especial
    if (_controller.lastCampania != item.campania)
    {
      _controller.lastCampania = item.campania;

      var totalCampaniaPesos = 0.0;
      for (ResumenOperarioOlsItem i in _controller.response.listaDeItems) {
        if (i.campania == _controller.lastCampania)
        {
          totalCampaniaPesos += i.totalPesos;
        }
      }
      
      header = Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
        child: Container(
                width: Get.width * 0.4,
                decoration: const BoxDecoration(
                  color: kTColorsTabsAnalisis,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.5),
                  child: Center(child: Column(
                    children: [
                      Text(item.campania, style: const TextStyle(fontSize: 13.0, color: kTAllLabelsColor, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5.0),
                      Text(Money.fromNumWithCurrency(totalCampaniaPesos, Constants.monedaAR).toString(), style: const TextStyle(fontSize: 14.0, color: kTCompartirIcono, fontWeight: FontWeight.bold)),
                    ],
                  )),
                ),
            ),
      );
    }

    return Column(
      children: [
        header,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text('${item.totalHas.toStringAsFixed(2)} has de ${item.especie}', style: const TextStyle(fontSize: 13.0, color: Colors.black54))),
                              const SizedBox(width: 10.0),
                              Text(Money.fromNumWithCurrency(item.totalPesos, Constants.monedaAR).toString(), style: const TextStyle(fontSize: 13.0, color: kTLightPrimaryColor, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  )
                ],
              ),
            ],
          ),
        footer,
      ],
    );
  }
}