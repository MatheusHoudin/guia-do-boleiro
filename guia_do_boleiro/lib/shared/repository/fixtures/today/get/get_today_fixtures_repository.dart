import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/today/get/get_today_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';

abstract class GetTodayFixturesRepository {
  Future<Either<Failure, List<Fixture>>> getFixturesFromToday(int leagueId);
}

class GetTodayFixturesRepositoryImpl extends GetTodayFixturesRepository {
  final NetworkInfo networkInfo;
  final GetTodayFixturesRemoteDataSource remoteDataSource;

  GetTodayFixturesRepositoryImpl({this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, List<Fixture>>> getFixturesFromToday(
      int leagueId) async {
    if (await networkInfo.isConnected) {

      try {
        final result = await remoteDataSource.getFixturesFromToday(leagueId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure(
          title: getTodayFixturesRepositoryServerFailureTitle,
          message: getTodayFixturesRepositoryServerFailureMessage
        ));
      }

    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}
