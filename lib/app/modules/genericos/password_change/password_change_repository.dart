
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/password_change_model.dart';

import 'password_change_provider.dart';


class PasswordChangeRepository {

  final apiProvider = Get.find<PasswordChangeProvider>();
  Future<PasswordChangeResponse> cambiarPassword(String tokenDeAcceso, String tokenDeRefresco, String password) async {
    return apiProvider.cambiarPassword(tokenDeAcceso, tokenDeRefresco, password);
  }

  
}