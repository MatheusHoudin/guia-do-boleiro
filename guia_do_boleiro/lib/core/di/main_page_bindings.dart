import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/api.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';

class MainPageBindings implements Bindings {
  @override
  void dependencies() {
    // Network info
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

    // Dio
    Get.lazyPut<Dio>(() => Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        headers: {
          apiKeyHeader: apiKey,
          apiHostHeader: apiHost
        }
      )
    ));
  }
}
