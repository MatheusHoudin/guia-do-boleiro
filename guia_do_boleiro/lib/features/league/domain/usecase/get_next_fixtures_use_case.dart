import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/next/get/get_next_fixtures_repository.dart';

class GetNextFixturesFromLeagueUseCase extends BaseUseCase<List<Fixture>, GetNextFixturesFromLeagueParams> {
  final GetNextFixturesRepository repository;

  GetNextFixturesFromLeagueUseCase({this.repository});

  @override
  Future<Either<Failure, List<Fixture>>> call(GetNextFixturesFromLeagueParams params) async {
    var response = await repository.getNextFixtures(params.leagueId);
    return response;
  }
}

class GetNextFixturesFromLeagueParams extends Equatable {
  final int leagueId;

  GetNextFixturesFromLeagueParams({this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
