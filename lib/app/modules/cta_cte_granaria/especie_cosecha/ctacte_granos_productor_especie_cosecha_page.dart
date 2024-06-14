import 'package:nexobyte/app/utils/utils.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'ctacte_granos_productor_especie_cosecha_controller.dart';


// ignore: must_be_immutable
class CtaCteProductorGranosEspecieCosechaPage extends GetView<CtaCteProductorEspecieCosechaController> {
  
  CtaCteProductorGranosEspecieCosechaPage({Key? key}) : super(key: key);

  CtaCteProductorEspecieCosechaItem? ctaCteProductorEspecieCosechaItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(color: kTIconColor),
          title: const Text("Cuentas Granarias", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              kTBackgroundContainer,
              controller.obx(
                (state)=> Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
                      itemCount: state!.listaDeSaldoProductorEspecieCosecha.length,
                      itemBuilder: (BuildContext context, int index) {
                        ctaCteProductorEspecieCosechaItem = state.listaDeSaldoProductorEspecieCosecha[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child: ShowProductorEspecieCosechaItem(itemCtaCteProductorEspecieCosechaItem: ctaCteProductorEspecieCosechaItem!),
                        );
                      }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Buscando tus cuentas corrientes granarias !'),
                onEmpty: const MyDataNotFoundMessage(),
                onError: (error) => MyCustomErrorMessage(error: error.toString()),
              ),
          ]
        ));
  }
}


// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowProductorEspecieCosechaItem extends StatelessWidget {
  
  final CtaCteProductorEspecieCosechaItem itemCtaCteProductorEspecieCosechaItem;
  
  const ShowProductorEspecieCosechaItem({
    Key? key,
    required this.itemCtaCteProductorEspecieCosechaItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.rCtacteGranariaDetalleMOV, arguments: itemCtaCteProductorEspecieCosechaItem),
        child: Card(
          color: kTBackgroundBtnHome,
          elevation: 30,
          shadowColor: kTLightPrimaryColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // if you need this
          ),
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // * ----------------------- PRODUCTOR Y EMPRESA
                        Text(itemCtaCteProductorEspecieCosechaItem.productor, style: const TextStyle(fontSize: 16.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold)),
                        //Text("HOMERO MALCONE (cta " + itemCtaCteProductorEspecieCosechaItem.clienteId.toString() + ")", style: const TextStyle(fontSize: 16.0, color: Colors.white54, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2.0),
                        Text(itemCtaCteProductorEspecieCosechaItem.empresa, style: const TextStyle(fontSize: 12.0, color: kTClientesLabelsColor)),
                        const SizedBox(height: 8.0),

                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: kTCircleAvatarBackgroundColor,
                              radius: 30,
                              backgroundImage: AssetImage('assets/img/${itemCtaCteProductorEspecieCosechaItem.especie.trim().toString().toLowerCase().replaceAll(' ', '_')}.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${itemCtaCteProductorEspecieCosechaItem.especie.trim()}   ${itemCtaCteProductorEspecieCosechaItem.cosecha}', style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kTLabelEspecieResumenHome)),
                                      const SizedBox(height: 3.0),
                                      Text("${numberFormat.format(itemCtaCteProductorEspecieCosechaItem.disponibleKgs)}  Kgs", style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: kTLabelEspeciePrecio)),
                                      const SizedBox(height: 3.0),
                                      Text("${numberFormat.format(itemCtaCteProductorEspecieCosechaItem.disponibleTn)}  TN", style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: kTLabelEspeciePrecio)),
                                      const SizedBox(height: 3.0),
                                    ],
                                  ),
                              ),
                            ],
                        ),

                        //*------------------------------------------------------ Compartir Resumen Ganario
                        //!-- ADD 3.0
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            focusColor: Colors.white,
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.share, color: kTLabelTextBoxLogin),
                                  SizedBox(width: 10.0),
                                  Text('Compartir', style: TextStyle(fontSize: 14.0, color: kTClientesLabelsColor)),
                                ],
                            ),
                            onTap: () => Get.toNamed(AppRoutes.rCtaCteGranariaResumenXls, arguments: itemCtaCteProductorEspecieCosechaItem),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward_ios, color: kTLightPrimaryColor)
                        ]
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
   );
    
  }
}

