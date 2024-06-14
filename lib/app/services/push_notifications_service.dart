import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyPushNotificationService {
  //?----------------------------------------------------------------------------------- Variables
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<RemoteMessage> _messageStreamFCM =
      StreamController.broadcast();
  static Stream<RemoteMessage> get messageStream => _messageStreamFCM.stream;

  //?----------------------------------------------------------------------------------- Cierre de Streams
  static closeStreams() {
    _messageStreamFCM.close();
  }

  //?----------------------------------------------------------------------------------- Esta en background o minimizada
  static Future<void> _backgroundHandler(RemoteMessage message) async {
    debugPrint(
        'Background Handler ${message.notification?.body ?? "Sin Body"}');
    //-- Cuando recibo la notificacion la agrego al stream para que avise a los suscriptores
    _messageStreamFCM.add(message);
  }

  //?----------------------------------------------------------------------------------- Cuando está abierta
  static Future<void> _onMessageHandler(RemoteMessage message) async {
    debugPrint(
        'On Message Handler ${message.notification?.body ?? "Sin Body"}');

    //-- Cuando recibo la notificacion la agrego al stream para que avise a los suscriptores
    _messageStreamFCM.add(message);
  }

  //?-----------------------------------------------------------------------------------
  static Future<void> _onMessageOpenedAppHandler(RemoteMessage message) async {
    debugPrint(
        'On Message Opened App Handler ${message.notification?.body ?? "Sin Body"}');

    //-- Cuando recibo la notificacion la agrego al stream para que avise a los suscriptores
    _messageStreamFCM.add(message);
  }

  //?----------------------------------------------------------------------------------- Inicializo MyPushNotificationService
  static Future initializeApp() async {
    //--- Push Notifications
    await Firebase.initializeApp();

    if (Platform.isIOS) {
      await requestPermissions();
    }

    token = await FirebaseMessaging.instance.getToken();
    debugPrint('token $token');

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedAppHandler);
  }

  // apple
  static requestPermissions() async {
    //NotificationSettings settings =
    await messaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: false,
      announcement: false,
      criticalAlert: false,
      sound: true,
      provisional: false,
    );
  }
}
