import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'modules/genericos/redirect/redirect_controller.dart';

class DependencyInjection {

  static void initServices() async {

    //-- Esto solucionó el error: Handshake error in client
    Dio dio = Dio(BaseOptions(baseUrl: Constants.urlBaseVersion));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    Get.lazyPut(() => dio, fenix: true);

    Get.lazyPut(() => RedirectController(), fenix: true);
    
 
  }
}


