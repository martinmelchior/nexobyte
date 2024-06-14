

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:money2/money2.dart';
import 'orden_laboreo_asientos_controller.dart';

class OrdenLaboreoAsientosPage extends GetView<OrdenLaboreoAsientosController> {
  
  const OrdenLaboreoAsientosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(color: kTIconColor),
          title: const Text("Asientos Contables", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
                    itemCount: controller.asientosContablesResponse.value.listaAsientosContables.length,
                    itemBuilder: (BuildContext context, int index) {
                      AsientoContableOL asiento = controller.asientosContablesResponse.value.listaAsientosContables[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text('Asiento ${ ++index }'),
                            const Divider(color: Colors.black38, height: 10.0),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Debe', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: kTImporteAFavor)),
                                Text('Haber', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: kTRedColor)),
                              ]
                            ),
                            const Divider(color: Colors.black38, height: 10.0),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
                              itemCount: asiento.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                AsientoContableItemOL item = asiento.items[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //const SizedBox(height: 5.0),
                                    Text(item.articulo, style: const TextStyle(fontSize: 12.0)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Visibility(
                                          visible: item.debe > 0.00,
                                          child: Text(Money.fromNumWithCurrency(item.debe, Constants.monedaAR).toString(),
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color:kTImporteAFavor)),
                                        ),
                                        Visibility(
                                          visible: item.haber > 0.00,
                                          child: Text(Money.fromNumWithCurrency(item.haber, Constants.monedaAR).toString(),
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: kTRedColor)),
                                        ),
                                      ]
                                    ),
                                    const SizedBox(height: 10.0),
                                ]);
                              }
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              color: Colors.black12.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(Money.fromNumWithCurrency(asiento.totalDebe, Constants.monedaAR).toString(),
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kTImporteAFavor)),

                                    Text(Money.fromNumWithCurrency(asiento.totalHaber, Constants.monedaAR).toString(),
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kTRedColor)),
                                  ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: SizedBox(
                          width: Get.width * 0.85,
                          child: const Text('CERRAR  OL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTLabelColorBtnIngresarLogin,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              )),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kTBackgroundColorBtnIngresarLogin),
                            elevation: MaterialStateProperty.all(15.0),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)))),
                        onPressed: () async {
                          Get.back(result: true);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        child: SizedBox(
                          width: Get.width * 0.85,
                          child: const Text('CANCELAR  CIERRE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTLabelColorBtnIngresarLogin,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              )),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.black),
                            elevation: MaterialStateProperty.all(15.0),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.0)))),
                        onPressed: () async {
                          Get.back(result: false);
                        },
                      ),
                    ],
                  ),
                      ),
                ),
          ],
        )
      ),
    );
  }


}