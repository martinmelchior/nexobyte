import 'package:get/get.dart';
import 'package:nexobyte/app/utils/device_info.dart';

class MantenimientoController extends GetxController {

  RxMap<String, dynamic> deviceData = <String, dynamic>{}.obs;  

  @override
  void onInit() async {
    super.onInit();
    deviceData.addAll(await DeviceInfo.inicializarPlatformState());
    deviceData.refresh();
  }
 

}
  
