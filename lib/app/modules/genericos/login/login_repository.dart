
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/login_model.dart';
import 'login_provider.dart';

class LoginRepository {

  final LoginProvider apiProvider = Get.find<LoginProvider>();

  Future<LoginResponse> autenticar(LoginRequest request) async {
    return apiProvider.autenticar(request);
  }

  
}