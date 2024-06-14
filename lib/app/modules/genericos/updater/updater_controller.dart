import 'dart:io';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'models/updater_model.dart';
import 'updater_provider.dart';

class UpdaterController extends GetxController {
  final UpdaterProvider _provider = Get.find<UpdaterProvider>();

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }

  @override
  void onReady() async {
    //-- ADD 2.2
    // if (!Constants.urlBase.contains(Constants.kUrlContaintTesting))
    // {

    //- En iphone muestro mensaje de que voy a hacer con la posicion
    //---------------------------------------------------------------------
    // if (Platform.isIOS) {

    //   if (PreferenciasDeUsuarioStorage.isFirstTime) {
    //     await MyDialog.myShowDialog(
    //         titulo: 'IMPORTANTE',
    //         mensaje: 'En un momento te pediremos autorización para permitirnos utilizar tu ubicación.\n\nSolo usaremos tu ubicación con el objetivo de brindarte información del CLIMA !');
    //   }

    // }

    //*-- V-LOCALIZACION-Begin - Obtengo la ubicación del dispositivo
    // try {
    //   Position position = await determinePosition();
    //   PreferenciasDeUsuarioStorage.latitud = position.latitude;
    //   PreferenciasDeUsuarioStorage.longitud = position.longitude;
    //   debugPrint("Latitud: ${position.latitude} - Longitud: ${position.longitude} ");

    //   await getAddressFromLatLng(PreferenciasDeUsuarioStorage.latitud, PreferenciasDeUsuarioStorage.longitud);
    // }
    // catch (e) {
    //   PreferenciasDeUsuarioStorage.lastError = e.toString();
    //   //*-- Error me quedo con la de córdoba
    //   PreferenciasDeUsuarioStorage.latitud = -31.417;
    //   PreferenciasDeUsuarioStorage.longitud = -64.183;
    //   debugPrint("Córdoba por error: ${PreferenciasDeUsuarioStorage.latitud} - Longitud: ${PreferenciasDeUsuarioStorage.longitud} ");
    // }
    //*-- V-LOCALIZACION-End

    try {
      GetVersionsResponse versionsResponse = await _provider.getVersions();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (Platform.isAndroid) {
        //*---------------------------------------------------------------------------------
        //*--- ANDROID
        //*---------------------------------------------------------------------------------
        int vAndroidNube =
            int.parse(versionsResponse.versionAndroid!.replaceAll('.', ''));
        int vAndroidLocal = int.parse(packageInfo.version.replaceAll('.', ''));
        if (vAndroidNube > vAndroidLocal) {
          MyDialog.myDialogNewVersion(
              url: versionsResponse.urlGooglePlay,
              versionNueva: versionsResponse.versionAndroid,
              versionActual: packageInfo.version);
        } else {
          Get.offNamed(AppRoutes.rRedirect);
        }
      } else if (Platform.isIOS) {
        //*---------------------------------------------------------------------------------
        //*--- IPHONE
        //*---------------------------------------------------------------------------------
        int vIosNube =
            int.parse(versionsResponse.versionIos!.replaceAll('.', ''));
        int vIosLocal = int.parse(packageInfo.version.replaceAll('.', ''));
        if (vIosNube > vIosLocal) {
          MyDialog.myDialogNewVersion(
              url: versionsResponse.urlAppleStore,
              versionNueva: versionsResponse.versionIos,
              versionActual: packageInfo.version);
        } else {
          Get.offNamed(AppRoutes.rRedirect);
        }
      } else {
        Get.offNamed(AppRoutes.rRedirect);
      }
    } catch (e) {
      Get.offNamed(AppRoutes.rRedirect);
    }

    // } else {
    //   Get.offNamed(AppRoutes.rRedirect);
    // }

    super.onReady();
  }
}
