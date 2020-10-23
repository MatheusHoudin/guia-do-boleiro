import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/live/get/get_live_fixtures_from_league_repository.dart';

class GetLiveFixturesFromLeagueUseCase extends BaseUseCase<List<Fixture>, GetLiveFixturesFromLeagueParams> {
  final GetLiveFixturesFromLeagueRepository repository;

  GetLiveFixturesFromLeagueUseCase({this.repository});

  @override
  Future<Either<Failure, List<Fixture>>> call(GetLiveFixturesFromLeagueParams params) async {
    var response = await repository.getLiveFixturesFromLeague(params.leagueId);
    return response;
  }
}


class GetLiveFixturesFromLeagueParams extends Equatable {
  final int leagueId;

  GetLiveFixturesFromLeagueParams({this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
