import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'comp_pendientes_filtro_controller.dart';

class CompPendientesFiltroPage extends GetView<CompPendientesFiltroController> {
  CompPendientesFiltroPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _key,
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBar(
              flexibleSpace: kTflexibleSpace,
              elevation: 10.0,
              backgroundColor: kTLightPrimaryColor,
              iconTheme: const IconThemeData(
                color: kTIconColor, //change your color here
              ),
              title: const Text("Seleccione el Cliente\na consultar",
                  style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
              centerTitle: true,
            ),
            body: Obx(() => Text(controller.isSearch.toString()))));
  }
}
