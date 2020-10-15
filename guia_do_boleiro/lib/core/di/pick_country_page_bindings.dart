import 'package:get/get.dart';
import 'package:guia_do_boleiro/features/get_seasons/domain/controller/get_seasons_controller.dart';
import 'package:guia_do_boleiro/features/get_seasons/domain/usecase/get_seasons_use_case.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/controller/get_countries_controller.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/usecase/get_countries_list_use_case.dart';
import 'package:guia_do_boleiro/shared/datasource/country/get/get_country_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/season/get/get_season_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/repository/country/get/get_country_repository.dart';
import 'package:guia_do_boleiro/shared/repository/season/get/get_seasons_repository.dart';

class PickCountryPageBindings implements Bindings {
  @override
  void dependencies() {
    // GetCountry
    Get.lazyPut<GetCountryRemoteDataSource>(() => GetCountryRemoteDataSourceImpl(
      client: Get.find()
    ));
    Get.lazyPut<GetCountryRepository>(() => GetCountryRepositoryImpl(
      networkInfo: Get.find(),
      remoteDataSource: Get.find()
    ));
    Get.lazyPut<GetCountriesListUseCase>(() => GetCountriesListUseCase(
      getCountryRepository: Get.find()
    ));
    Get.put<GetCountriesController>(GetCountriesController(
      getCountriesListUseCase: Get.find()
    ));

    // GetSeasons
    Get.lazyPut<GetSeasonsRemoteDataSource>(() => GetSeasonsRemoteDataSourceImpl(
      client: Get.find()
    ));
    Get.lazyPut<GetSeasonsRepository>(() => GetSeasonsRepositoryImpl(
      networkInfo: Get.find(),
      getSeasonRemoteDataSource: Get.find()
    ));
    Get.lazyPut<GetSeasonsUseCase>(() => GetSeasonsUseCase(
      repository: Get.find()
    ));
    Get.put<GetSeasonsController>(GetSeasonsController(
      useCase: Get.find()
    ));
  }

}
