import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/repository/leagues/round/get/get_league_rounds_repository.dart';

class GetLeagueRoundsUseCase extends BaseUseCase<List<String>, GetLeagueRoundsParams> {
  final GetRoundsFromLeagueRepository repository;

  GetLeagueRoundsUseCase({this.repository});

  @override
  Future<Either<Failure, List<String>>> call(GetLeagueRoundsParams params) async {
    final response = await repository.getRoundsFromLeague(params.leagueId);
    return response;
  }
}

class GetLeagueRoundsParams extends Equatable {
  final int leagueId;

  GetLeagueRoundsParams({this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
