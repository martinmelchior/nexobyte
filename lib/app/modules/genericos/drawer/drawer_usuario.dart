import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'drawer_usuario_controller.dart';

class DrawerUsuario extends GetView<DrawerUsuarioController> {
  const DrawerUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<DrawerUsuarioController>(() => DrawerUsuarioController());

    _menuCtaCte() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rCtacteResumenCliente),
        child: SizedBox(
          height: 30.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Expanded(
                    flex: 1, 
                    child: Image.asset(Constants.kImgCtaCte, width: 25, height: 25)),
                const Expanded(
                    flex: 5,
                    child: Text('Cta Cte', style: TextStyle(color: kTDrawerLabelColor))),
                const Expanded(
                    flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
              ],
            
          ),
        ),
      );
    }

    _menuGranos() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rCtacteGranariaResumenPEC),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1, 
                child: Image.asset(Constants.kImgCtaCteGranos, width: 25, height: 25)),
              const Expanded(
                flex: 5,
                child: Text('Granos', style: TextStyle(color: kTDrawerLabelColor))),
              const Expanded(
                flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
            ],
          ),
        ),
      );
    }

    _menuCerrarSesion() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rCerrarSesion),
        child: const SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, 
                child:Icon(Icons.exit_to_app, color: kTDrawerIconColor)),
              Expanded(
                flex: 6, 
                child:Text('Cerrar Sessión', style: TextStyle(color: kTDrawerLabelColor))),
            ],
          ),
        ),
      );
    }

    _menuInfoApp() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rAppVersion),
        child: const SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, 
                child:Icon(Icons.info_outline, color: kTDrawerIconColor)),
              Expanded(
                flex: 6, 
                child: Text('Información de la App',
                  style: TextStyle(color: kTDrawerLabelColor))),
            ],
          ),
        ),
      );
    }

    _menuMisClientes() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rCtacteResumenClienteVEN),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, 
                child: Image.asset(Constants.kImgMisClientesVEN, width: 25, height: 25)),
              const Expanded(
                flex: 5,
                child: Text('Mis Clientes', style: TextStyle(color: kTDrawerLabelColor))),
              const Expanded(
                flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
            ],
          ),
        ),
      );
    }

    _menuLaboreosContratistas() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rResumenOLContratista),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, 
                child: Image.asset(Constants.kImgOLA, width: 25, height: 25)),
              const Expanded(
                flex: 5,
                child: Text('Ordenes de Laboreos', style: TextStyle(color: kTDrawerLabelColor))),
              const Expanded(
                flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
            ],
          ),
        ),
      );
    }

    _menuPosiciones() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rPOSUsuarioResumen),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, 
                child: Image.asset(Constants.kImgPOS, width: 25, height: 25)),
              const Expanded(
                flex: 5,
                child: Text('Mis Posiciones', style: TextStyle(color: kTDrawerLabelColor))),
              const Expanded(
                flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
            ],
          ),
        ),
      );
    }

    _menuFeedback() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rEnviarFeedback),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, 
                child: Image.asset(Constants.kImgFeedback, width: 25, height: 25)),
              const Expanded(
                flex: 5,
                child: Text('Necesito Ayuda', style: TextStyle(color: kTDrawerLabelColor))),
              const Expanded(
                flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
            ],
          ),
        ),
      );
    }

    _menuAnalisisMani() {
      return InkWell(
        onTap: () => Get.toNamed(AppRoutes.rCtacteGranariaResumenPEC),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1, 
                child: Image.asset(Constants.kImgAnalisisMani, width: 25, height: 25)),
              const Expanded(
                flex: 5,
                child: Text('Análisis de Mani', style: TextStyle(color: kTDrawerLabelColor))),
              const Expanded(
                flex: 1, child: Icon(Icons.arrow_right, color: kTDrawerIconColor)),
            ],
          ),
        ),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(backgroundColor: kTLightPrimaryColor3),
      child: Drawer(
        semanticLabel: "Menu",
        child: Stack(
          children: [
            kTBackgroundContainer,
            Column(
              children: [
                _buildDrawerHeader(context),
                Obx(() => Visibility(
                  visible: controller.applicationSettingsController.appShowServicioCtaCte.value,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          _menuCtaCte(),
                        ],
                      ),
                    )),
                Obx(() => Visibility(
                      visible: controller.applicationSettingsController
                          .appShowServicioCtaCteGranaria.value,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          _menuGranos(),
                        ],
                      ),
                    )),
                
                Obx(() => Visibility(
                      visible: controller.applicationSettingsController
                          .appShowServicioVendedor.value,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          _menuMisClientes(),
                        ],
                      ),
                    )),
                Obx(() => Visibility(
                  visible: controller.applicationSettingsController.appShowServicioOLContratista.value,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      _menuLaboreosContratistas(),
                    ],
                  ),
                )),
                Obx(() => Visibility(
                  visible: controller.applicationSettingsController.appShowServicioPosiciones.value,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      _menuPosiciones(),
                    ],
                  ),
                )),
                const SizedBox(height: 20.0),
                _menuFeedback(),
                const SizedBox(height: 20.0),
                _menuInfoApp(),
                const SizedBox(height: 20.0),
                _menuCerrarSesion(),
                const Expanded(child: SizedBox(height: 200)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildDrawerHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Image.asset(Constants.kLogoDrawer),
            ),
            Text('${PreferenciasDeUsuarioStorage.nombre.capitalize} ${PreferenciasDeUsuarioStorage.apellido.capitalize}', style: const TextStyle(fontSize: 16.0, color: kTAllLabelsColor)),
            Text(PreferenciasDeUsuarioStorage.email, style: const TextStyle(fontSize: 12, color: kTAllLabelsColor)),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
