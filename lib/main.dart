import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'app/data/models/preferencias_de_usuario_model.dart';
import 'app/dependency_injection.dart';
import 'app/routes/pages_app.dart';
import 'app/routes/routes_app.dart';
import 'app/services/push_notifications_service.dart';
import 'app/theme/app_theme.dart';

void main() async {
  //*--  Si o si debe estar esta línea antes
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //*--  Creamos preferencia del usuario vacias si no existen
  await PreferenciasDeUsuarioStorage.inicializar(PreferenciasUsuario().toJson());

  //*-- Despues de WidgetsFlutterBinding
  //*-- Llamar siempre despues de inicializar las preferencias del usuario para guardar token en mobile
  await MyPushNotificationService.initializeApp();

  //*-- Piso token en propiedades del usuario del mobile
  PreferenciasDeUsuarioStorage.tokenMobile = MyPushNotificationService.token ?? '';

  //*-- Inyectamos dependencias
  DependencyInjection.initServices();

  MyPushNotificationService.messageStream.listen((message) {
    PreferenciasDeUsuarioStorage.abrirNotificaciones = true;

    Get.snackbar(
      message.notification?.title ?? 'Sin titulo',
      message.notification?.body ?? '',
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white, // kTLabelEspecieResumenHome,
      colorText: Colors.black87,
      borderRadius: 5.0,
      margin: const EdgeInsets.all(20),
      isDismissible: false,
      onTap: (_) => Get.toNamed(AppRoutes.rNotificaciones),
    );
  });

  //*-- Solo Vertical
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(GetMaterialApp(
      //-- Recordar agregar flutter_localizations: sdk: flutter en pubspect.yaml y el import aqui arriba
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //-- localización
      supportedLocales: const [
        Locale('en'),
        Locale('es', 'AR'), // Español, no country code
      ],
      //-- Recordar agregar flutter_localizations: sdk: flutter en pubspect.yaml y el import aqui arriba
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.rUpdater,
      theme: lightTheme.copyWith(primaryColor: kTLightPrimaryColor),
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
    ));
  });
}
