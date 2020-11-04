import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/formatter.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/leagues/round/get/get_league_rounds_remote_data_source.dart';

abstract class GetRoundsFromLeagueRepository {
  Future<Either<Failure, List<String>>> getRoundsFromLeague(int leagueId);
}

class GetRoundsFromLeagueRepositoryImpl extends GetRoundsFromLeagueRepository {
  final NetworkInfo networkInfo;
  final GetLeagueRoundsRemoteDataSource remoteDataSource;

  GetRoundsFromLeagueRepositoryImpl({this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getRoundsFromLeague(int leagueId) async {
    try {
      if (await networkInfo.isConnected) {
        var response = await remoteDataSource.getLeagueRounds(leagueId);
        response = response.map((round) => formatRound(round)).toList();
        return Right(response);
      }else{
        return Left(NoInternetConnectionFailure());
      }
    } on ServerException {
      return Left(ServerFailure(
        title: getLeagueRoundsRepositoryServerFailureTitle,
        message: getLeagueRoundsRepositoryServerFailureMessage
      ));
    }
  }
}
