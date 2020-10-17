import 'package:get/get.dart';
import 'package:guia_do_boleiro/features/countryleagues/domain/controller/get_country_leagues_controller.dart';
import 'package:guia_do_boleiro/features/countryleagues/domain/usecase/get_country_leagues_use_case.dart';
import 'package:guia_do_boleiro/shared/datasource/leagues/countries/get/get_country_leagues_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/repository/leagues/countries/get/get_country_leagues_repository.dart';

class CountryLeaguesPageBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GetCountryLeaguesRemoteDataSource>(() =>
        GetCountryLeaguesRemoteDataSourceImpl(client: Get.find()));

    Get.lazyPut<GetCountryLeaguesRepository>(() => GetCountryLeaguesRepositoryImpl(
      networkInfo: Get.find(),
      remoteDataSourceImpl: Get.find()
    ));

    Get.lazyPut<GetCountryLeaguesUseCase>(() => GetCountryLeaguesUseCase(repository: Get.find()));

    Get.put<GetCountryLeaguesController>(GetCountryLeaguesController(useCase: Get.find()));
  }
}
