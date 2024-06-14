import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/consolida_especie/ctacte_granaria_consolida_especie_controller.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/consolida_tambos/consolida_tambos_home_controller.dart';
import 'package:nexobyte/app/modules/genericos/controllers/aplicacion_settings/application_settings_controller.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/model/model_cotizaciones.dart';
import 'package:nexobyte/app/modules/genericos/home/home_provider.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/locator_manager.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:nexobyte/app/utils/utils.dart';

class HomeController extends GetxController {
  final ConsolidaTambosController _litrosTambosController =
      Get.find<ConsolidaTambosController>();
  ConsolidaTambosController get litrosTambosController =>
      _litrosTambosController;

  final CtaCteGranariaConsolidaEspecieController _saldosEspeciesController =
      Get.find<CtaCteGranariaConsolidaEspecieController>();
  CtaCteGranariaConsolidaEspecieController get saldosEspeciesController =>
      _saldosEspeciesController;

  final ApplicationSettingsController _appSettingController =
      Get.find<ApplicationSettingsController>();
  ApplicationSettingsController get applicationSettingsController =>
      _appSettingController;

  final isLoaded = true.obs;

  @override
  void onReady() async {
    try {
      await loadData();

      if (PreferenciasDeUsuarioStorage.aceptoTYC == false) {
        // * ADD v2.0 (server) - Debe aceptar los nuevos terminos y condiciones
        Get.toNamed(AppRoutes.rAceptarTyC);
      }

      //*-- v4.1
      //*----------------------------------------------------
      if (PreferenciasDeUsuarioStorage.enviarUbicacion) {
        await tomarUbicacionYEnviarla();
      }

      if (Platform.isAndroid) {
        //*-- PERMISOS DE NOTIFICACIONES
        PermissionStatus status = await Permission.notification.request();
        if (status.isGranted) {
        } else {
          Get.snackbar(
            "Ooops",
            "Recuerda dar permisos para recibir notificaciones !",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.error, color: Colors.white),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            borderRadius: 0.0,
            margin: const EdgeInsets.all(0),
          );
        }
      }
    } catch (e) {
      if (e.toString().contains('ACCESO DENEGADO')) {
        //-- Fuerzo a login
        PreferenciasDeUsuarioStorage.isFirstTime = true;
      }

      ApiExceptions.procesarError(e);
    } finally {
      super.onReady();
    }
  }

  Future<void> loadData() async {
    isLoaded.toggle();

    //* Cargo ApplicationSettiongs !!
    await applicationSettingsController.loadApplicationSettings();

    //* Cargo Saldos por especies ??
    // if (applicationSettingsController.appShowServicioCtaCteGranaria.value)
    // {
    //   await saldosEspeciesController.loadSaldosPorEspecie();
    // }

    //* Cargo litros mes por tambo  ??
    if (applicationSettingsController.appShowServicioLecheria.value) {
      await litrosTambosController.obtenerResumenLitrosMesActual();
    }

    //-- ADD 2.4
    await obtenerCotizacionesMonedasYCereales();
  }

  //*----------------------------------------------------- tomarUbicacionYEnviarla
  Future<void> tomarUbicacionYEnviarla() async {
    Position? position;
    try {
      Get.dialog(const Center(child: kTCpi), barrierDismissible: false);
      position = await determinePosition();
      PreferenciasDeUsuarioStorage.latitud = position.latitude;
      PreferenciasDeUsuarioStorage.longitud = position.longitude;
      getAddressFromLatLng(PreferenciasDeUsuarioStorage.latitud,
          PreferenciasDeUsuarioStorage.longitud);

      await _provider.guardarUbicacion();
      Get.back();

      EstadisticasDeUso.send("Envía Ubicación (lat, long)");
    } catch (e) {
      Get.back();

      position = await getLastKnownPosition();
      if (position != null) {
        PreferenciasDeUsuarioStorage.latitud = position.latitude;
        PreferenciasDeUsuarioStorage.longitud = position.longitude;
        await _provider.guardarUbicacion();
      }
    }
  }

  //-- ADD 2.4
  final HomeProvider _provider = Get.find<HomeProvider>();
  List<CotizacionCereal> listaCotizacionCereal = <CotizacionCereal>[].obs;
  List<CotizacionMoneda> listaCotizacionMoneda = <CotizacionMoneda>[].obs;

  //*----------------------------------------------------- obtenerCotizacionesMonedasYCereales
  Future<CotizacionCerealesYMonedasResponse>
      obtenerCotizacionesMonedasYCereales() async {
    CotizacionCerealesYMonedasResponse response =
        CotizacionCerealesYMonedasResponse();
    try {
      response = await _provider.obtenerCotizacionesMonedasYCereales();
      listaCotizacionMoneda.assignAll(response.listaCotizacionMoneda);
      listaCotizacionCereal.assignAll(response.listaCotizacionCereal);
      return response;
    } catch (e) {}
    return response;
  }
}
