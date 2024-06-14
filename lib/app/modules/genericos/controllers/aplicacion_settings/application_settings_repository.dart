


import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/application_settings_model.dart';

import 'application_settings_provider.dart';


class ApplicationSettingsRepository {

  final ApplicationSettingsProvider apiProvider = Get.find<ApplicationSettingsProvider>();

  Future<ApplicationSettingsResponse> loadApplicationSettings(ApplicationSettingsRequest request) async {
    return apiProvider.loadApplicationSettings(request);
  }

  
}