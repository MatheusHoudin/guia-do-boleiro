import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/live/get/get_live_fixtures_from_league_data_source.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

abstract class GetLiveFixturesFromLeagueRepository {
  Future<Either<Failure,List<Fixture>>> getLiveFixturesFromLeague(int leagueId);
}

class GetLiveFixturesFromLeagueRepositoryImpl extends GetLiveFixturesFromLeagueRepository {
  final NetworkInfo networkInfo;
  final GetLiveFixturesFromLeagueRemoteDataSource remoteDataSource;

  GetLiveFixturesFromLeagueRepositoryImpl({this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, List<Fixture>>> getLiveFixturesFromLeague(int leagueId) async{
    if (await networkInfo.isConnected) {
      try {
        final fixtures = await remoteDataSource.getLiveFixturesFromLeague(leagueId);
        return Right(fixtures);
      } on ServerException {
        return Left(ServerFailure(
          title: getLiveFixturesFromLeagueRepositoryServerFailureTitle,
          message: getLiveFixturesFromLeagueRepositoryServerFailureMessage
        ));
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}
