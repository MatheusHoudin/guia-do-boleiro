import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/leagues/round/current/get/get_current_round_for_league_remote_data_source.dart';

abstract class GetCurrentRoundForLeagueRepository {
  Future<Either<Failure, String>> getCurrentRoundForLeague(int leagueId);
}

class GetCurrentRoundForLeagueRepositoryImpl
    extends GetCurrentRoundForLeagueRepository {
  final NetworkInfo networkInfo;
  final GetCurrentRoundForLeagueRemoteDataSource remoteDataSource;

  GetCurrentRoundForLeagueRepositoryImpl(
      {this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, String>> getCurrentRoundForLeague(int leagueId) async {
    try {
      if (await networkInfo.isConnected) {
        var response =
            await remoteDataSource.getCurrentRoundForLeague(leagueId);
        return Right(response);
      } else {
        return Left(NoInternetConnectionFailure());
      }
    } on ServerException {
      return Left(ServerFailure(
          title: getCurrentRoundForLeagueRepositoryFailureTitle,
          message: getCurrentRoundForLeagueRepositoryFailureMessage));
    }
  }
}
