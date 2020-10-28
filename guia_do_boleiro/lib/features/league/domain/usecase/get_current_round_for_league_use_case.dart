import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/repository/leagues/round/current/get_current_round_for_league_repository.dart';

class GetCurrentRoundForLeagueUseCase
    extends BaseUseCase<String, GetCurrentRoundForLeagueParams> {
  final GetCurrentRoundForLeagueRepository repository;

  GetCurrentRoundForLeagueUseCase({this.repository});

  @override
  Future<Either<Failure, String>> call(
      GetCurrentRoundForLeagueParams params) async {
    final response = await repository.getCurrentRoundForLeague(params.leagueId);
    return response;
  }
}

class GetCurrentRoundForLeagueParams extends Equatable {
  final int leagueId;

  GetCurrentRoundForLeagueParams({this.leagueId});

  @override
  List<Object> get props => [leagueId];
}
