import 'package:get/get.dart';
import 'package:guia_do_boleiro/features/league/domain/controller/league_controller.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_current_round_for_league_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_league_rounds_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_live_fixtures_from_league_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_next_fixtures_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_round_fixtures_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_today_fixtures_use_case.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/live/get/get_live_fixtures_from_league_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/next/get/get_next_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/round/get/get_round_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/today/get/get_today_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/leagues/round/current/get/get_current_round_for_league_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/datasource/leagues/round/get/get_league_rounds_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/live/get/get_live_fixtures_from_league_repository.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/next/get/get_next_fixtures_repository.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/round/get/get_round_fixtures_repository.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/today/get/get_today_fixtures_repository.dart';
import 'package:guia_do_boleiro/shared/repository/leagues/round/current/get_current_round_for_league_repository.dart';
import 'package:guia_do_boleiro/shared/repository/leagues/round/get/get_league_rounds_repository.dart';

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
    Get.lazyPut<GetLeagueRoundsRemoteDataSource>(
        () => GetLeagueRoundsRemoteDataSourceImpl(client: Get.find()));
    Get.lazyPut<GetNextFixturesRemoteDataSource>(
        () => GetNextFixturesRemoteDataSourceImpl(client: Get.find()));
    Get.lazyPut<GetCurrentRoundForLeagueRemoteDataSource>(() => GetCurrentRoundForLeagueRemoteDataSourceImpl(client: Get.find()));

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
    Get.lazyPut<GetRoundsFromLeagueRepository>(() =>
        GetRoundsFromLeagueRepositoryImpl(
            remoteDataSource: Get.find(), networkInfo: Get.find()));
    Get.lazyPut<GetNextFixturesRepository>(() => GetNextFixturesRepositoryImpl(
        networkInfo: Get.find(), remoteDataSource: Get.find()));
    Get.lazyPut<GetCurrentRoundForLeagueRepository>(() => GetCurrentRoundForLeagueRepositoryImpl(remoteDataSource: Get.find(), networkInfo: Get.find()));

    // Use cases
    Get.lazyPut<GetLiveFixturesFromLeagueUseCase>(
        () => GetLiveFixturesFromLeagueUseCase(repository: Get.find()));
    Get.lazyPut<GetRoundFixturesUseCase>(
        () => GetRoundFixturesUseCase(repository: Get.find()));
    Get.lazyPut<GetTodayFixturesUseCase>(
        () => GetTodayFixturesUseCase(repository: Get.find()));
    Get.lazyPut<GetLeagueRoundsUseCase>(
        () => GetLeagueRoundsUseCase(repository: Get.find()));
    Get.lazyPut<GetNextFixturesFromLeagueUseCase>(
        () => GetNextFixturesFromLeagueUseCase(repository: Get.find()));
    Get.lazyPut<GetCurrentRoundForLeagueUseCase>(() => GetCurrentRoundForLeagueUseCase(repository: Get.find()));

    // Controllers
    Get.put<LeagueController>(LeagueController(
        getLiveFixturesFromLeagueUseCase: Get.find(),
        getRoundFixturesUseCase: Get.find(),
        getTodayFixturesUseCase: Get.find(),
        getLeagueRoundsUseCase: Get.find(),
        getNextFixturesFromLeagueUseCase: Get.find(),
        getCurrentRoundForLeagueUseCase: Get.find()
    ));
  }
}
