

import 'package:dio/dio.dart' as dd;
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/password_recovery_model.dart';


class PasswordRecoveryProvider {

  final dd.Dio _dio = Get.find<dd.Dio>();

  Future<PasswordRecoveryResponse> recuperar(PasswordRecoveryRequest request) async {
   
    final dd.Response r = await _dio.post("/passwordrecovery/recuperar", 
                                            data: {
                                              "email": request.email, 
                                            });

    return PasswordRecoveryResponse.fromJson(r.data);  
  }

}