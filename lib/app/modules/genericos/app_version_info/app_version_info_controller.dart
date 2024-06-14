import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionInfoController extends GetxController {
  final _packageInfo = PackageInfo(appName: '', packageName: '', version: '', buildNumber: '').obs;
  set packageInfo(PackageInfo info) {
    _packageInfo.value = info;
    _packageInfo.refresh();
  }

  PackageInfo get packageInfo => _packageInfo.value;

  final _dataPlayStore = ''.obs;
  set dataPlayStore(value) => _dataPlayStore.value = value;
  get dataPlayStore => _dataPlayStore.value;

  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();

    try {

      //final newVersion = NewVersion();
      //final status = await newVersion.getVersionStatus();
      // if (status != null) {
      //   dataPlayStore = 'Local: ${status.localVersion} - Store: ${status.storeVersion} - Actualizar: ${status.canUpdate ? 'Si' : 'No'}';
      // } else {
      //   dataPlayStore = 'No pudimos obtener los datos!';
      // }
    
    } catch (e) {
        dataPlayStore = 'No pudimos obtener los datos!';
    }

  }
}
