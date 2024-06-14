import 'package:flutter/material.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/consolida_tambos/consolida_tambos_home_widget.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:get/get.dart';

import 'cta_cte_leche_resumen_controller.dart';

class CtaCteLecheResumenPage extends GetView<CtaCteLecheResumenController> {
  
  const CtaCteLecheResumenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: const Text("Resumen de Tambos", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: Stack(children: [
          kTBackgroundContainer,
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ConsolidaTambosHomeWidget(),
          )
        ]));
  }
}
