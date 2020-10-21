import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/round/get/get_round_fixtures_repository.dart';
import 'package:guia_do_boleiro/shared/repository/fixtures/today/get/get_today_fixtures_repository.dart';

class GetTodayFixturesUseCase extends BaseUseCase<List<Fixture>,GetTodayFixturesParams> {
  final GetTodayFixturesRepository repository;

  GetTodayFixturesUseCase({this.repository});

  @override
  Future<Either<Failure, List<Fixture>>> call(GetTodayFixturesParams params) async {
    final result = await repository.getFixturesFromToday(params.leagueId);
    return result;
  }
}

class GetTodayFixturesParams extends Equatable {
  final int leagueId;

  GetTodayFixturesParams({this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
