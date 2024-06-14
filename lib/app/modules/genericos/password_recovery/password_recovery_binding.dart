

import 'package:get/get.dart';
import 'password_recovery_controller.dart';
import 'password_recovery_provider.dart';
import 'password_recovery_repository.dart';

class PasswordRecoveryBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<PasswordRecoveryController>(() => PasswordRecoveryController());
    Get.lazyPut<PasswordRecoveryRepository>(() => PasswordRecoveryRepository());
    Get.lazyPut<PasswordRecoveryProvider>(() => PasswordRecoveryProvider());
  }

}