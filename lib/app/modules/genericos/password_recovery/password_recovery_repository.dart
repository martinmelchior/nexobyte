
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/password_recovery_model.dart';
import 'password_recovery_provider.dart';

class PasswordRecoveryRepository {

  final PasswordRecoveryProvider apiProvider = Get.find<PasswordRecoveryProvider>();

  Future<PasswordRecoveryResponse> recuperar(PasswordRecoveryRequest request) async {
    return apiProvider.recuperar(request);
  }

  
}