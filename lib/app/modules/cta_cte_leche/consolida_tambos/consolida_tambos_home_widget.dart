import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'consolida_tambos_home_controller.dart';

// ignore: must_be_immutable
class ConsolidaTambosHomeWidget extends GetView<ConsolidaTambosController> {
  const ConsolidaTambosHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.litrosMesTamboResponse.value.listaDeResumenDeLitrosItem.isNotEmpty
       ? ListView.builder(
          shrinkWrap: true,
          //physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
          itemCount: controller.litrosMesTamboResponse.value.listaDeResumenDeLitrosItem.length,
          itemBuilder: (BuildContext context, int index) {
            return Tambos.showHeaderTambo(controller.litrosMesTamboResponse.value.listaDeResumenDeLitrosItem[index],true);
          })
        : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No hemos encontrado información para mostrarte !'),
          );
  }
}
