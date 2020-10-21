import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/shared/repository/leagues/countries/get/get_country_leagues_repository.dart';

class GetCountryLeaguesUseCase extends BaseUseCase<List<League>, CountryAndSeasonParams> {
  final GetCountryLeaguesRepository repository;

  GetCountryLeaguesUseCase({this.repository});

  @override
  Future<Either<Failure, List<League>>> call(CountryAndSeasonParams params) async {
    final leaguesOrFailure = await repository.getLeagues(params.country, params.season);
    return leaguesOrFailure;
  }
}

class CountryAndSeasonParams extends Equatable {
  final String country;
  final String season;

  CountryAndSeasonParams({this.country, this.season});

  @override
  List<Object> get props => [country, season];
}
