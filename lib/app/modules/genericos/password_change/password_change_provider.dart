

import 'package:dio/dio.dart' as dd;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/password_change_model.dart';


class PasswordChangeProvider {

  final dd.Dio _dio = Get.find<dd.Dio>();

  Future<PasswordChangeResponse> cambiarPassword(String tokenDeAcceso, String tokenDeRefresco, String password) async {
    
    final dd.Response r = await _dio.post("/passwordrecovery/change",  
                                  data: { 
                                    "tokenDeAcceso"   : tokenDeAcceso, 
                                    "tokenDeRefresco" : tokenDeRefresco, 
                                    "password"        : password }
                                  );

    return PasswordChangeResponse.fromJson(r.data);

  }

}