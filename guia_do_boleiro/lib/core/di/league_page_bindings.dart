import 'package:get/get.dart';
import 'package:guia_do_boleiro/features/league/domain/controller/league_controller.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_live_fixtures_from_league_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_round_fixtures_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_today_fixtures_use_case.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/live/get/get_live_fixtures_from_league_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/round/get/get_round_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/today/get/get_today_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/live/get/get_live_fixtures_from_league_repository.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/round/get/get_round_fixtures_repository.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/today/get/get_today_fixtures_repository.dart';

class LeaguePageBindings extends Bindings {
  @override
  void dependencies() {
    // Remote data sources
    Get.lazyPut<GetTodayFixturesRemoteDataSource>(
        () => GetTodayFixturesRemoteDataSourceImpl(client: Get.find()));
    Get.lazyPut<GetRoundFixturesRemoteDataSource>(
        () => GetRoundFixturesRemoteDataSourceImpl(client: Get.find()));
    Get.lazyPut<GetLiveFixturesFromLeagueRemoteDataSource>(() =>
        GetLiveFixturesFromLeagueRemoteDataSourceImpl(client: Get.find()));

    // Repositories
    Get.lazyPut<GetTodayFixturesRepository>(() =>
        GetTodayFixturesRepositoryImpl(
            networkInfo: Get.find(), remoteDataSource: Get.find()));
    Get.lazyPut<GetRoundFixturesRepository>(() =>
        GetRoundFixturesRepositoryImpl(
            networkInfo: Get.find(), remoteDataSource: Get.find()));
    Get.lazyPut<GetLiveFixturesFromLeagueRepository>(() =>
        GetLiveFixturesFromLeagueRepositoryImpl(
            networkInfo: Get.find(), remoteDataSource: Get.find()));

    // Use cases
    Get.lazyPut<GetLiveFixturesFromLeagueUseCase>(
        () => GetLiveFixturesFromLeagueUseCase(repository: Get.find()));
    Get.lazyPut<GetRoundFixturesUseCase>(
        () => GetRoundFixturesUseCase(repository: Get.find()));
    Get.lazyPut<GetTodayFixturesUseCase>(
        () => GetTodayFixturesUseCase(repository: Get.find()));

    // Controllers
    Get.put<LeagueController>(LeagueController(
        getLiveFixturesFromLeagueUseCase: Get.find(),
        getRoundFixturesUseCase: Get.find(),
        getTodayFixturesUseCase: Get.find()));
  }
}
