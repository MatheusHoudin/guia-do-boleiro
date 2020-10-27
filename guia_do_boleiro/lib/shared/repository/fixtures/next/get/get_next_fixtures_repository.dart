import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/next/get/get_next_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';

abstract class GetNextFixturesRepository {
  Future<Either<Failure, List<Fixture>>> getNextFixtures(int leagueId);
}

class GetNextFixturesRepositoryImpl extends GetNextFixturesRepository {
  final NetworkInfo networkInfo;
  final GetNextFixturesRemoteDataSource remoteDataSource;

  GetNextFixturesRepositoryImpl({this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, List<Fixture>>> getNextFixtures(
      int leagueId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNextFixtures(leagueId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure(
          title: getNextFixturesRepositoryServerFailureTitle,
          message: getNextFixturesRepositoryServerFailureMessage
        ));
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}
