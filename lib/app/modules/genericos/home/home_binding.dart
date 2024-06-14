import 'package:get/get.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/consolida_especie/ctacte_granaria_consolida_especie_controller.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/consolida_especie/ctacte_granaria_consolida_especie_provider.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/consolida_especie/ctacte_granaria_consolida_especie_repository.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/consolida_tambos/consolida_tambos_home_controller.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/consolida_tambos/consolida_tambos_home_provider.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/consolida_tambos/consolida_tambos_home_repository.dart';
import 'package:nexobyte/app/modules/genericos/controllers/aplicacion_settings/application_settings_controller.dart';
import 'package:nexobyte/app/modules/genericos/controllers/aplicacion_settings/application_settings_provider.dart';
import 'package:nexobyte/app/modules/genericos/controllers/aplicacion_settings/application_settings_repository.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/cereales/cotizacion_cereales_controller.dart';
import 'package:nexobyte/app/modules/genericos/home/home_provider.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //-- ADD 2.4
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeProvider>(() => HomeProvider());

    Get.lazyPut<ApplicationSettingsController>(
        () => ApplicationSettingsController());
    Get.lazyPut<ApplicationSettingsRepository>(
        () => ApplicationSettingsRepository());
    Get.lazyPut<ApplicationSettingsProvider>(
        () => ApplicationSettingsProvider());

    Get.lazyPut<CtaCteGranariaConsolidaEspecieController>(
        () => CtaCteGranariaConsolidaEspecieController());
    Get.lazyPut<CtaCteGranariaConsolidaEspecieRepository>(
        () => CtaCteGranariaConsolidaEspecieRepository());
    Get.lazyPut<CtaCteGranariaConsolidaEspecieProvider>(
        () => CtaCteGranariaConsolidaEspecieProvider());

    Get.lazyPut<ConsolidaTambosController>(() => ConsolidaTambosController());
    Get.lazyPut<ConsolidaTambosRepository>(() => ConsolidaTambosRepository());
    Get.lazyPut<ConsolidaTambosProvider>(() => ConsolidaTambosProvider());

    Get.lazyPut<CotizacionCerealesController>(
        () => CotizacionCerealesController());
  }
}
