
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';

import 'models/updater_model.dart';


class UpdaterProvider extends GetConnect {

  final d.Dio _dio = Get.find<d.Dio>();

  Future<GetVersionsResponse> getVersions() async {
    final d.Response r = await _dio.post("/usuarios/getVersions");
    return GetVersionsResponse.fromJson(r.data);  
  }

}