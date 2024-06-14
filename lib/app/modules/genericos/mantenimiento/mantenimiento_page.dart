import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'mantenimiento_controller.dart';

class MantenimientoPage extends GetView<MantenimientoController> {
  const MantenimientoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _infoTile(String title, String subtitle) {
      return ListTile(
        title: Text(title),
        subtitle: Text(subtitle.isNotEmpty ? subtitle : ''),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: kTLightPrimaryColor1,
          centerTitle: true,
          title:
              const Text("Información Extra", style: TextStyle(fontSize: 17)),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _infoTile(
                'Ultimo Error',
                PreferenciasDeUsuarioStorage.lastError.isEmpty
                    ? 'Nada por aquí!'
                    : PreferenciasDeUsuarioStorage.lastError),
            Obx(() => Column(
                  children: <Widget>[
                    ...controller.deviceData.keys.map((String property) {
                      return Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(property,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                              child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Text('${controller.deviceData[property]}',
                                maxLines: 10, overflow: TextOverflow.ellipsis),
                          )),
                        ],
                      );
                    }).toList(),
                  ],
                )),
          ],
        )));
  }
}
