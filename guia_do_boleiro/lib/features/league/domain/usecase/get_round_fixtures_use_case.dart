import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/round/get/get_round_fixtures_repository.dart';

class GetRoundFixturesUseCase
    extends BaseUseCase<List<Fixture>, RoundFixturesParams> {
  final GetRoundFixturesRepository repository;

  GetRoundFixturesUseCase({this.repository});

  @override
  Future<Either<Failure, List<Fixture>>> call(RoundFixturesParams params) async {
    var response =
        await repository.getRoundFixtures(params.league, params.round);
    return response;
  }
}

class RoundFixturesParams extends Equatable {
  final int league;
  final String round;

  RoundFixturesParams({this.league, this.round});

  @override
  List<Object> get props => [this.league, this.round];
}
