import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_version_info_controller.dart';

class AppVersionInfoPage extends StatelessWidget {
  
  final AppVersionInfoController controller = Get.find<AppVersionInfoController>();

  AppVersionInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _infoTile(String title, String subtitle) {
      return ListTile(
        title: Text(title),
        subtitle: Text(subtitle.isNotEmpty ? subtitle : ''),
      );
    }

    return Scaffold(
      backgroundColor: kTScaffoldBackColor,
      appBar: AppBar(
        backgroundColor: kTLightPrimaryColor1,
        centerTitle: true,
        title: const Text("Información de la APP", style: TextStyle(fontSize: 17, color: kTAllLabelsColor)),
        iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
      ),
      body: Obx(() => CustomScrollView(
  slivers: [
    SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _infoTile('Nombre', controller.packageInfo.appName),
              //_infoTile('Paquete', controller.packageInfo.packageName),
              _infoTile('Versión instalada', controller.packageInfo.version),
              _infoTile('Nro Interno', controller.packageInfo.buildNumber),
              // Obx(() => _infoTile('Versiones', controller.dataPlayStore)),
              // _infoTile('Pais', PreferenciasDeUsuarioStorage.pais),
              // _infoTile('CP', PreferenciasDeUsuarioStorage.cp),
              // _infoTile('Localidad', PreferenciasDeUsuarioStorage.localidad),
              const Expanded(child: SizedBox(height: 20.0)),
              Expanded(
                child: InkWell(
                  onTap: () async => {
                    if (await canLaunchUrl(Uri.parse(Constants.urlDesarrolladoPor))) {
                      await launchUrl(
                        Uri.parse(Constants.urlDesarrolladoPor),
                        mode: LaunchMode.externalApplication)
                    } 
                  },
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Desarrollado por', style: TextStyle(fontSize: 13.0)),
                      ),
                      Image.asset("assets/img/nexoLogo.png", width: 180.0, fit: BoxFit.fitWidth,),
                    ],
                  ),
                ),
              )
            ],
          ))])),
    );
  }
}
