import 'package:get/get.dart';

import 'enviar_feedback_controller.dart';
import 'enviar_feedback_provider.dart';


class EnviarFeedbackBinding implements Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut(() => EnviarFeedbackController());
    Get.lazyPut(() => EnviarFeedbackProvider());
      
  }

}